//
//  NetworkMethod+Parameters.swift
//  UnitTests
//
//  Created by Ronald Mannak on 10/24/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Foundation
import Swifthereum
import BigInt


extension NetworkMethod {

    /**
     Returns the expected http body in string format. Swifthereum 
     */
    var expectedBody: String {
        switch (self) {
        case .clientVersion: return """
            {"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":67}
            """
        case .sha3(_): return """
            {"jsonrpc":"2.0","method":"web3_sha3","params":["0x68656c6c6f20776f726c64"],"id":64}
            """
        case .networkID: return """
            {"jsonrpc":"2.0","method":"net_version","params":[],"id":67}
            """
        case .peerCount: return """
            {"jsonrpc":"2.0","method":"net_peerCount","params":[],"id":74}
            """
        case .listening: return """
            {"jsonrpc":"2.0","method":"net_listening","params":[],"id":67}
            """
        case .protocolVersion: return """
            {"jsonrpc":"2.0","method":"eth_protocolVersion","params":[],"id":67}
            """
        case .isSyncing: return """
            {"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}
            """
        case .coinbase: return """
            {"jsonrpc":"2.0","method":"eth_coinbase","params":[],"id":64}
            """
        case .isMining: return """
            {"jsonrpc":"2.0","method":"eth_mining","params":[],"id":71}
            """
        case .hashrate: return """
            {"jsonrpc":"2.0","method":"eth_hashrate","params":[],"id":71}
            """
        case .gasPrice: return """
            {"jsonrpc":"2.0","method":"eth_gasPrice","params":[],"id":73}
            """
        case .accounts: return """
            {"jsonrpc":"2.0","method":"eth_accounts","params":[],"id":1}
            """
        case .blockNumber: return """
            {"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":83}
            """
        case .balance(_, _): return """
            {"jsonrpc":"2.0","method":"eth_getBalance","params":["0x407d73d8a49eeb85d32cf465507dd71d507100c1","latest"],"id":1}
            """
//        case .storage(_, _): return """
//            {"jsonrpc":"2.0", "method": "eth_getStorageAt", "params": ["0x295a70b2de5e3953354a6a8344e616ed314d7251", "0x0", "latest"], "id": 1}
//            """
        case .transactionCount(_, _): return """
            {"jsonrpc":"2.0","method":"eth_getTransactionCount","params":["0x407d73d8a49eeb85d32cf465507dd71d507100c1","latest"],"id":1}
            """
        case .blockTransactionCount(_): return """
            {"jsonrpc":"2.0","method":"eth_getBlockTransactionCountByHash","params":["0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238"],"id":1}
            """
        case .blockTransactionCountByNumber(let defaultBlock):
            switch defaultBlock {
            case .number(_):
                return """
                {"jsonrpc":"2.0","method":"eth_getBlockTransactionCountByNumber","params":["0xe8"],"id":1}
                """
            case .earliest:
                return """
                {"jsonrpc":"2.0","method":"eth_getBlockTransactionCountByNumber","params":["earliest"],"id":1}
                """
            case .genesis:
                // genesis is not listed as a valid parameter in the documentation
                return """
                {"jsonrpc":"2.0","method":"eth_getBlockTransactionCountByNumber","params":["genesis"],"id":1}
                """
            case .latest:
                return """
                {"jsonrpc":"2.0","method":"eth_getBlockTransactionCountByNumber","params":["latest"],"id":1}
                """
            case .pending:
                return """
                {"jsonrpc":"2.0","method":"eth_getBlockTransactionCountByNumber","params":["pending"],"id":1}
                """
            }
        case .uncleCount(_): return """
            {"jsonrpc":"2.0","method":"eth_getUncleCountByBlockHash","params":["0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238"],"id":1}
            """
        case .uncleCountByBlockNumber(_): return """
            {"jsonrpc":"2.0","method":"eth_getUncleCountByBlockNumber","params":["0xe8"],"id":1}
            """
        case .code(_, _): return """
            {"jsonrpc":"2.0","method":"eth_getCode","params":["0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b", "0x2"],"id":1}
            """
        case .sign(_, _): return """
            {"jsonrpc":"2.0","method":"eth_sign","params":["0x9b2055d370f73ec7d8a03e965129118dc8f5bf83", "0xdeadbeaf"],"id":1}
            """
        case .sendTransaction(_): return """
            {"jsonrpc":"2.0","method":"eth_sendTransaction","params":[{see above}],"id":1}
            """
        case .sendRawTransaction(_): return """
            {"jsonrpc":"2.0","method":"eth_sendRawTransaction","params":[{see above}],"id":1}
            """
        case .call(_): return """
            {"jsonrpc":"2.0","method":"eth_call","params":[{see above}],"id":1}
            """
        case .estimateGas(_): return """
            {"jsonrpc":"2.0","method":"eth_estimateGas","params":[{see above}],"id":1}
            """
        case .blockByHash(_): return """
            {"jsonrpc":"2.0","method":"eth_getBlockByHash","params":["0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331", true],"id":1}
            """
        case .blockByNumber(_): return """
            {"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["0x1b4", true],"id":1}
            """
        case .transaction(_): return """
            {"jsonrpc":"2.0","method":"eth_getTransactionByHash","params":["0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238"],"id":1}
            """
        case .transactionByBlockHashAndIndex(_, _): return """
            {"jsonrpc":"2.0","method":"eth_getTransactionByBlockNumberAndIndex","params":["0x29c", "0x0"],"id":1}
            """
        case .transactionByBlockNumberAndIndex(_, _): return """
            {"jsonrpc":"2.0","method":"eth_getTransactionReceipt","params":["0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238"],"id":1}
            """
        case .receipt(_): return """
            {"jsonrpc":"2.0","method":"eth_getUncleByBlockHashAndIndex","params":["0xc6ef2fc5426d6ad6fd9e2a26abeab0aa2411b7ab17f30a99d3cb96aed1d1055b", "0x0"],"id":1}
            """
        case .uncleByBlockHashAndIndex(_, _): return """
            {"jsonrpc":"2.0","method":"eth_getUncleByBlockNumberAndIndex","params":["0x29c", "0x0"],"id":1}
            """
        case .uncleByBlockNumberAndIndex(_, _): return """
            {"jsonrpc":"2.0","method":"eth_getCompilers","params":[],"id":1}
            """
        case .compilers: return """
            {"jsonrpc":"2.0","method":"eth_compileSolidity","params":["contract test { function multiply(uint a) returns(uint d) {   return a * 7;   } }"],"id":1}
            """
        case .compileSolidity(_): return """
            {"jsonrpc":"2.0","method":"eth_compileSolidity","params":["contract test { function multiply(uint a) returns(uint d) {   return a * 7;   } }"],"id":1}
            """
        case .compileLLL(_): return """
            {"jsonrpc":"2.0","method":"eth_compileLLL","params":["(returnlll (suicide (caller)))"],"id":1}
            """
        case .compileSerpent(_): return """
            {"jsonrpc":"2.0","method":"eth_compileSerpent","params":["/* some serpent */"],"id":1}
            """
        case .notification(_): return """
            {"jsonrpc":"2.0","method":"eth_newFilter","params":[{"topics":["0x12341234"]}],"id":73}
            """
        case .newBlockNotification: return """
            {"jsonrpc":"2.0","method":"eth_newBlockFilter","params":[],"id":73}
            """
        case .newPendingTransactionNotification: return """
            {"jsonrpc":"2.0","method":"eth_newPendingTransactionFilter","params":[],"id":73}
            """
        case .uninstallNotification(_): return """
            {"jsonrpc":"2.0","method":"eth_uninstallFilter","params":["0xb"],"id":73}
            """
        case .notificationChanges(_): return """
            {"jsonrpc":"2.0","method":"eth_getFilterChanges","params":["0x16"],"id":73}
            """
        case .notificationLogs(_): return """
            {"jsonrpc":"2.0","method":"eth_getFilterLogs","params":["0x16"],"id":74}
            """
        case .logs(_): return """
            {"jsonrpc":"2.0","method":"eth_getLogs","params":[{"topics":["0x000000000000000000000000a94f5374fce5edbc8e2a8697c15331677e6ebf0b"]}],"id":74}
            """
        case .work: return """
            {"jsonrpc":"2.0","method":"eth_getWork","params":[],"id":73}
            """
        case .submitWork(_): return """
            {"jsonrpc":"2.0", "method":"eth_submitWork", "params":["0x0000000000000001", "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef", "0xD1GE5700000000000000000000000000D1GE5700000000000000000000000000"],"id":73}
            """
        case .submitHashrate(_, _): return """
            {"jsonrpc":"2.0", "method":"eth_submitHashrate", "params":["0x0000000000000000000000000000000000000000000000000000000000500000", "0x59daa26581d0acd1fce254fb7e85952f4c09d0915afd33d3886cd914bc7d283c"],"id":73}
            """
        case .putString(_, _, _): return """
            {"jsonrpc":"2.0","method":"db_putString","params":["testDB","myKey","myString"],"id":73}
            """
        case .getString(_, _): return """
            {"jsonrpc":"2.0","method":"db_getString","params":["testDB","myKey"],"id":73}
            """
        case .putHex(_, _, _): return """
            {"jsonrpc":"2.0","method":"db_putHex","params":["testDB","myKey","0x68656c6c6f20776f726c64"],"id":73}
            """
        case .getHex(_, _): return """
            {"jsonrpc":"2.0","method":"db_getHex","params":["testDB","myKey"],"id":73}
            """
            
        // SSH
        case .sshVersion: return """
            {"jsonrpc":"2.0","method":"shh_version","params":[],"id":67}
            """
        case .sshPost: return """
            {"jsonrpc":"2.0","method":"shh_post","params":[{"from":"0xc931d93e97ab07fe42d923478ba2465f2","topics": ["0x68656c6c6f20776f726c64"],"payload":"0x68656c6c6f20776f726c64","ttl":0x64,"priority":0x64}],"id":73}
            """
       
        case .sshNewIdentity: return """
            {"jsonrpc":"2.0","method":"shh_newIdentity","params":[],"id":73}
            """
        case .sshHasIdentity: return """
            {"jsonrpc":"2.0","method":"shh_hasIdentity","params":["0x04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a03e245533f97284d442460f2998cd41858798ddfd4d661997d3940272b717b1"],"id":73}
            """
        case .sshNewGroup: return """
            {"jsonrpc":"2.0","method":"shh_newGroup","params":["  "0x04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a03e245533f97284d442460f2998cd41858798ddfd4d661997d3940272b717b1"],"id":73}
            """
        case .sshAddToGroup: return """
            {"jsonrpc":"2.0","method":"shh_addToGroup","params":["0x04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a03e245533f97284d442460f2998cd41858798ddfd4d661997d3940272b717b1"],"id":73}
            """
        case .sshNewFilter: return """
            {"jsonrpc":"2.0","method":"shh_newFilter","params":[{"topics": ['0x12341234bf4b564f'],"to": "0x2341234bf4b2341234bf4b564f..."}],"id":73}
            """
        case .sshUninstallFilter: return """
            {"jsonrpc":"2.0","method":"shh_uninstallFilter","params":["0x7"],"id":73}
            """
        case .sshGetFilterChanges: return """
            {"jsonrpc":"2.0","method":"shh_getFilterChanges","params":["0x7"],"id":73}
            """
        case .sshGetMessages: return """
            {"jsonrpc":"2.0","method":"shh_getMessages","params":["0x7"],"id":73}
            """
        }
    }
    
    var expectedHttpMethod: String {
        switch (self) {
        default:
            return "POST"
        }
    }
}
