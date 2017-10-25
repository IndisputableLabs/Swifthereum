//
//  NetworkMethod+UnitTests.swift
//  UnitTests
//
//  Created by Ronald Mannak on 10/23/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Foundation
import Swifthereum
import BigInt


extension BigIntWrapper {
    var response: String {
        return ""
    }
}

extension NetworkMethod {
 
    /**
     Literal response from Geth node.
     */
    var response: String {
        switch self {
        case .clientVersion: return """
            {"jsonrpc":"2.0","id":67,"result":"Geth/v1.7.2-stable-1db4ecdc/darwin-amd64/go1.9.1"}
        """
        case .sha3(_): return """
            {"jsonrpc":"2.0","id":67,"result":"0x18717f9beb6218ec217dc7eb4bb738281516963d7fc4d5eb70e8f3782f376df0"}
            """
        case .networkID: return """
            {"jsonrpc":"2.0","id":67,"result":"4"}
            """
        case .peerCount: return """
            {"jsonrpc":"2.0","id":67,"result":"0x3"}
            """
        case .listening: return """
            {"jsonrpc":"2.0","id":67,"result":true}
            """
        case .protocolVersion: return """
            {"jsonrpc":"2.0","id":67,"result":"0x3f"}
            """
        case .isSyncing: return """
            {"jsonrpc":"2.0","id":67,"result":false}
            """
        case .coinbase: return """
            {"jsonrpc":"2.0","id":67,"result":"0xb81df5747f39bfd5ce9410f1be9b02851b0cbd6e"}
            """
        case .isMining: return """
            {"jsonrpc":"2.0","id":67,"result":false}
            """
        case .hashrate: return """
            {"jsonrpc":"2.0","id":67,"result":"0x0"}
            """
        case .gasPrice: return """
            {"jsonrpc":"2.0","id":67,"result":"0x4e3b29200"}
            """
        case .accounts: return """
            {"jsonrpc":"2.0","id":67,"result":["0xb81df5747f39bfd5ce9410f1be9b02851b0cbd6e","0x0a16d2efbeef080a342a941aa99e505bd50df4f7","0xe1a40604d1d889fb6760055f0b78d433e794d74a"]}
            """
        case .blockNumber: return """
            {"id":83,"jsonrpc":"2.0","result":"0x4b7"}
            """
        case .balance(_, _): return """
            {"id":1,"jsonrpc":"2.0","result":"0x0234c8a3397aab58"}
            """
//        case .storage(_, _): return """
//            {"jsonrpc":"2.0","id":1,"result":"0x00000000000000000000000000000000000000000000000000000000000004d2"}
//            """
        case .transactionCount(_, _): return """
            {"id":1,"jsonrpc":"2.0","result":"0x1"}
            """
        case .blockTransactionCount(_): return """
            {"id":1,"jsonrpc":"2.0","result":"0xb"}
            """
        case .blockTransactionCountByNumber(_): return """
            {"id":1,"jsonrpc":"2.0","result":"0xa"}
            """
        case .uncleCount(_): return """
            {"id":1,"jsonrpc":"2.0","result":"0x1"}
            """
        case .uncleCountByBlockNumber(_): return """
            {"id":1,"jsonrpc":"2.0","result":"0x1"}
            """
        case .code(_, _): return """
            {"id":1,"jsonrpc":"2.0","result": "0x600160008035811a818181146012578301005b601b6001356025565b8060005260206000f25b600060078202905091905056"}
            """
        case .sign(_, _): return """
            {"id":1,"jsonrpc":"2.0","result": "0xa3f20717a250c2b0b729b7e5becbff67fdaef7e0699da4de7ca5895b02a170a12d887fd3b17bfdce3481f10bea41f45ba9f709d39ce8325427b57afcfc994cee1b"}
            """
        case .sendTransaction(_): return """
            {"id":1,"jsonrpc":"2.0","result":"0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331"}
            """
        case .sendRawTransaction(_): return """
            {"id":1,"jsonrpc":"2.0","result":"0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331"}
            """
        case .call(_): return """
            {"id":1,"jsonrpc":"2.0","result":"0x"}
            """
        case .estimateGas(_): return """
            {"id":1,"jsonrpc":"2.0","result":"0x5208"}
            """
        case .blockByHash(_): return """
            {"id":1,"jsonrpc":"2.0","result": {"number": "0x1b4","hash": "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331","parentHash":"0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5","nonce":"0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2","sha3Uncles":"0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347","logsBloom":"0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331","transactionsRoot":"0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421","stateRoot":"0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff","miner":"0x4e65fda2159562a496f9f3522f89122a3088497a","difficulty":"0x027f07","totalDifficulty":"0x027f07","extraData":"0x0000000000000000000000000000000000000000000000000000000000000000","size":"0x027f07","gasLimit": "0x9f759","gasUsed": "0x9f759","timestamp": "0x54e34e8e","transactions":[{...},{ ... }],"uncles": ["0x1606e5...", "0xd5145a9..."]}}
            """
        case .blockByNumber(_): return """
            """
        case .transaction(_): return """
            """
        case .transactionByBlockHashAndIndex(_, _): return """
            """
        case .transactionByBlockNumberAndIndex(_, _): return """
            """
        case .receipt(_): return """
            """
        case .uncleByBlockHashAndIndex(_, _): return """
            """
        case .uncleByBlockNumberAndIndex(_, _): return """
            """
        case .compilers: return """
            """
        case .compileSolidity(_): return """
            """
        case .compileLLL(_): return """
            """
        case .compileSerpent(_): return """
            """
        case .notification(_): return """
            """
        case .newBlockNotification: return """
            """
        case .newPendingTransactionNotification: return """
            """
        case .uninstallNotification(_): return """
            """
        case .notificationChanges(_): return """
            """
        case .notificationLogs(_): return """
            """
        case .logs(_): return """
            """
        case .work: return """
            """
        case .submitWork(_): return """
            """
        case .submitHashrate(_, _): return """
            """
        case .putString(_, _, _): return """
            """
        case .getString(_, _): return """
            """
        case .putHex(_, _, _): return """
            """
        case .getHex(_, _): return """
            """
            
        // SSH
        case .sshPost: return """
            """
        case .sshVersion: return """
            """
        case .sshNewIdentity: return """
            """
        case .sshHasIdentity: return """
            """
        case .sshNewGroup: return """
            """
        case .sshAddToGroup: return """
            """
        case .sshNewFilter: return """
            """
        case .sshUninstallFilter: return """
            """
        case .sshGetFilterChanges: return """
            """
        case .sshGetMessages: return """
            """
        }
    }
 
    /**
     Results in the Swifthereum correct data format
     */
     var correctResult: Any {
        switch self {
        case .clientVersion: return "Geth/v1.7.2-stable-1db4ecdc/darwin-amd64/go1.9.1"
        case .sha3(_): return Hash(hex: "0x18717f9beb6218ec217dc7eb4bb738281516963d7fc4d5eb70e8f3782f376df0")!
        case .networkID: return 4
        case .peerCount: return 3
        case .listening: return true
        case .protocolVersion: return 64
        case .isSyncing: return false
        case .coinbase: return Hash(hex: "0xb81df5747f39bfd5ce9410f1be9b02851b0cbd6e")!
        case .isMining: return false
        case .hashrate: return 0
        case .gasPrice: return Wei("4e3b29200")!
        case .accounts: return [Address(hex: "0xb81df5747f39bfd5ce9410f1be9b02851b0cbd6e")!, Address(hex: "0x0a16d2efbeef080a342a941aa99e505bd50df4f7")!, Address(hex: "0xe1a40604d1d889fb6760055f0b78d433e794d74a")!]
        case .blockNumber: return 1207
        case .balance(_, _): return Wei("158972490234375000")!
//        case .storage(_, _): return """
//            """
        case .transactionCount(_, _): return 1
        case .blockTransactionCount(_): return 11
        case .blockTransactionCountByNumber(_): return 10
        case .uncleCount(_): return 1
        case .uncleCountByBlockNumber(_): return 1
        case .code(_, _): return Hash(hex: "0x600160008035811a818181146012578301005b601b6001356025565b8060005260206000f25b600060078202905091905056")!
        case .sign(_, _): return """
            Hash(hex: "0xa3f20717a250c2b0b729b7e5becbff67fdaef7e0699da4de7ca5895b02a170a12d887fd3b17bfdce3481f10bea41f45ba9f709d39ce8325427b57afcfc994cee1b")
            """
        case .sendTransaction(_): return Bytes32Hash(hex: "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")!
        case .sendRawTransaction(_): return Bytes32Hash(hex: "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")!
        case .call(_): return Hash(hex:"0x")!
        case .estimateGas(_): return 21000
        case .blockByHash(_):            
            return Block(number: 436,
                         blockHash: BlockHash(hex: "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")!,
                         parentHash: BlockHash(hex: "0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5")!,
                         nonce: Hash(hex: "0xe04d296d2460cfb8472af2c5fd05b5a214109c25688d3704aed5484f9a7792f2")!,
                         sha3Uncles: [BlockHash(hex: "0x1dcc4de8dec75d7aab85b567b6ccd41ad312451b948a7413f0a142fd40d49347")!],
                         logsBloom: Hash(hex: "0xe670ec64341771606e55d6b4ca35a1a6b75ee3d5145a99d05921026d1527331")!,
                         transactionsRoot: Hash(hex: "0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421")!,
                         stateRoot: Hash(hex:"0xd5855eb08b3387c0af375e9cdb6acfc05eb8f519e419b874b6ff2ffda7ed1dff")!,
                         miner: Address(hex: "0x4e65fda2159562a496f9f3522f89122a3088497a")!,
                         difficulty: BigInt(163591),
                         totalDifficulty: BigInt(163591),
                         extraData: Hash(hex:"0x0000000000000000000000000000000000000000000000000000000000000000")!,
                         size: 163591,
                         gasLimit: Wei(653145),
                         gasUsed: Wei(653145),
                         timeStamp: 1424182926,
                         transactions: [TransactionHash(hex: "0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421")!],
                         uncles: [BlockHash(hex: "0x9646252be9520f6e71339a8df9c55e4d7619deeb018d2a3f2d21fc165dde5eb5")!])
        case .blockByNumber(_): return """
            """
        case .transaction(_): return """
            """
        case .transactionByBlockHashAndIndex(_, _): return """
            """
        case .transactionByBlockNumberAndIndex(_, _): return """
            """
        case .receipt(_): return """
            """
        case .uncleByBlockHashAndIndex(_, _): return """
            """
        case .uncleByBlockNumberAndIndex(_, _): return """
            """
        case .compilers: return """
            """
        case .compileSolidity(_): return """
            """
        case .compileLLL(_): return """
            """
        case .compileSerpent(_): return """
            """
        case .notification(_): return """
            """
        case .newBlockNotification: return """
            """
        case .newPendingTransactionNotification: return """
            """
        case .uninstallNotification(_): return """
            """
        case .notificationChanges(_): return """
            """
        case .notificationLogs(_): return """
            """
        case .logs(_): return """
            """
        case .work: return """
            """
        case .submitWork(_): return """
            """
        case .submitHashrate(_, _): return """
            """
        case .putString(_, _, _): return """
            """
        case .getString(_, _): return """
            """
        case .putHex(_, _, _): return """
            """
        case .getHex(_, _): return """
            """
            
        // SSH
        case .sshPost: return """
            """
        case .sshVersion: return """
            """
        case .sshNewIdentity: return """
            """
        case .sshHasIdentity: return """
            """
        case .sshNewGroup: return """
            """
        case .sshAddToGroup: return """
            """
        case .sshNewFilter: return """
            """
        case .sshUninstallFilter: return """
            """
        case .sshGetFilterChanges: return """
            """
        case .sshGetMessages: return """
            """
        }
     }
    
    var errorResult: String {
        return "{\"jsonrpc\":\"2.0\",\"id\":67,\"error\":{\"code\":-32601,\"message\":\"The method web3_clientVersion2 does not exist/is not available\"}}"
    }
 }
