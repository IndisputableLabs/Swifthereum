//
//  EndpointTest.swift
//  UnitTests
//
//  Created by Ronald Mannak on 10/24/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Foundation
import XCTest
import Swifthereum
import BigInt
@testable import Unit


// Testing if URL endpoints and parameters are passed correctly

class EndpointTest: XCTestCase {
    
    var server: Server!
    struct UnexpectedNilError: Error {}
    
    override func setUp() {
        super.setUp()
        server = Server()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // web3 calls
    func testClientVersion() throws { try endpoint(for: .clientVersion) }
    func testSha3() throws { try endpoint(for: .sha3("0x68656c6c6f20776f726c64")) }

    // Net calls
    func testNetworkdID() throws { try endpoint(for: .networkID) }
    func testPeerCount() throws { try endpoint(for: .peerCount) }
    func testListening() throws { try endpoint(for: .listening) }

    // Ethereum calls
    func testProtocolVersion() throws { try endpoint(for: .protocolVersion) }
    func testIsSyncing() throws { try endpoint(for: .isSyncing) }
    func testCoinbase() throws { try endpoint(for: .coinbase) }
    func testIsMining() throws { try endpoint(for: .isMining) }
    func testHashrate() throws { try endpoint(for: .hashrate) }
    func testGasPrice() throws { try endpoint(for: .gasPrice) }
    func testAccounts() throws { try endpoint(for: .accounts) }
    func testBlockNumber() throws { try endpoint(for: .blockNumber) }
    func testBalance() throws { try endpoint(for: .balance(Address(hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1")!, .latest)) }

    func testTransactionCount() throws { try endpoint(for: .transactionCount(Address(hex: "0x407d73d8a49eeb85d32cf465507dd71d507100c1")!, .latest)) }
    func testBlockTransactionCount() throws { try endpoint(for: .blockTransactionCount(BlockHash(hex: "0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238")!)) }
    func testBlockTransactionCountByNumber1() throws { try endpoint(for: .blockTransactionCountByNumber(.number(232))) }
    func testBlockTransactionCountByNumber2() throws { try endpoint(for: .blockTransactionCountByNumber(.earliest)) }
    func testBlockTransactionCountByNumber3() throws { try endpoint(for: .blockTransactionCountByNumber(.latest)) }
    func testBlockTransactionCountByNumber4() throws { try endpoint(for: .blockTransactionCountByNumber(.pending)) }
    func testBlockTransactionCountByNumber5() throws { try endpoint(for: .blockTransactionCountByNumber(.genesis)) }

    func testUncleCount() throws { try endpoint(for: .uncleCount(BlockHash(hex: "0xb903239f8543d04b5dc1ba6579132b143087c68db1b2168786408fcbce568238")!)) }
    func testUncleCountByBlockNumber1() throws { try endpoint(for: .uncleCountByBlockNumber(.number(232))) }
    func testUncleCountByBlockNumber2() throws { try endpoint(for: .uncleCountByBlockNumber(.earliest)) }
    func testUncleCountByBlockNumber3() throws { try endpoint(for: .uncleCountByBlockNumber(.latest)) }
    func testUncleCountByBlockNumber4() throws { try endpoint(for: .uncleCountByBlockNumber(.pending)) }
    func testUncleCountByBlockNumber5() throws { try endpoint(for: .uncleCountByBlockNumber(.genesis)) }

    func testCode1() throws { try endpoint(for: .code(Address(hex: "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b")!, .number(2))) }
    func testCode2() throws { try endpoint(for: .code(Address(hex: "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b")!, .earliest)) }
    func testCode3() throws { try endpoint(for: .code(Address(hex: "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b")!, .latest)) }
    func testCode4() throws { try endpoint(for: .code(Address(hex: "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b")!, .pending)) }
    func testCode5() throws { try endpoint(for: .code(Address(hex: "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b")!, .genesis)) }

    func testSign() throws { try endpoint(for: .sign(Address(hex: "0x9b2055d370f73ec7d8a03e965129118dc8f5bf83")!, Hash(hex: "0xdeadbeaf")!))}
    func testSendTransaction() throws {
        let transaction = NewTransaction(from: Address(hex: "0xb60e8dd61c5d32be8058bb8eb970870f07233155")!, to: Address(hex: "0xd46e8dd67c5d32be8058bb8eb970870f07244567")!, gas: 30400, gasPrice: 10000000000000, value: 2441406250, data: Hash(hex: "0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675"))
        try endpoint(for: .sendTransaction(transaction))
    }
    
    
    /*
        /*
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
         */
        try endpoint(for: .compilers)
        
        /*
        case .compileSolidity(_): return """
        """
        case .compileLLL(_): return """
        """
        case .compileSerpent(_): return """
        """
        case .notification(_): return """
        """*/
        
        try endpoint(for: .newBlockNotification)
        try endpoint(for: .newPendingTransactionNotification)
        
        /*
        
        case .uninstallNotification(_): return """
        """
        case .notificationChanges(_): return """
        """
        case .notificationLogs(_): return """
        """
        case .logs(_): return """
         */
        
        try endpoint(for: .work)
        /*
        
        
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
        """ */
    }
    */
    
    // SSH Tests
    /*
    func testSshPost() throws {
        print("04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a03e245533f97284d442460f2998cd41858798ddfd4d661997d3940272b717b1".count)
        let to = WhisperAddress(hex: "0x04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a03e245533f97284d442460f2998cd41858798ddfd4d661997d3940272b717b1")
        XCTAssertNotNil(to)
        let from = WhisperAddress(hex: "0x3e245533f97284d442460f2998cd41858798ddf04f96a5e25610293e42a73908e93ccc8c4d4dc0edcfa9fa872f50cb214e08ebf61a0d4d661997d3940272b717b1")
        XCTAssertNotNil(from)
        let topic1 = Hash(hex: "0x776869737065722d636861742d636c69656e74")
        XCTAssertNotNil(topic1)
        let topic2 = Hash(hex: "0x4d5a695276454c39425154466b61693532")
        XCTAssertNotNil(topic2)
        let payload = Hash(hex: "0x7b2274797065223a226d6")
        XCTAssertNotNil(payload)
        
        let post = WhisperPost(from: to!,
                               to: from!,
                               topics: [topic1!, topic2!],
                               payload: payload!,
                               priority: 100,
                               ttl: 100)
        try endpoint(for: .sshPost(post))
    } */            
    
    func testSshVersion() throws { try endpoint(for: .sshVersion) }
    func testSshNewIdentity() throws { try endpoint(for: .sshNewIdentity) }
    /*func testSshHasIdentity() throws { try endpoint(for: .sshHasIdentity) }
    func testSshNewGroup() throws { try endpoint(for: .sshNewGroup) }
    func testSshAddToGroup() throws { try endpoint(for: .sshAddToGroup) }
    func testSshNewFilter() throws { try endpoint(for: .sshNewFilter) }
    func testSshUninstallFilter() throws { try endpoint(for: .sshUninstallFilter(7)) }
    func testSshGetFilterChanges() throws { try endpoint(for: .sshGetFilterChanges) }
    func testSshGetMessages() throws { try endpoint(for: .sshGetMessages) }
    */
    // test if error in a parameter dictionary is detected
    func testSanity() throws {
        
        // Invalid method
        let invalidParameterString = """
        {"jsonrpc":"2.0","method":"web3_invalidMethod","params":[],"id":67}
        """
        
        // Invalid json rpc version
        // version is always set to 2.0 No need to test
//        let invalidParameterString2 = """
//        {"jsonrpc":"3.0","method":"web3_clientVersion","params":[],"id":67}
//        """
        
        // Invalid parameter
        let invalidParameterString3 = """
        {"jsonrpc":"2.0","method":"web3_clientVersion","params":["invalidParameter"],"id":67}
        """
        
        // Expected JSON
        let validParameterString = """
        {"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":2}
        """
        
        let invalid1 = try JSONDecoder().decode(Rpc.self, from: invalidParameterString.data(using: .utf8)!)
//        let invalid2 = try JSONDecoder().decode(Rpc.self, from: invalidParameterString2.data(using: .utf8)!)
        let invalid3 = try JSONDecoder().decode(Rpc.self, from: invalidParameterString3.data(using: .utf8)!)
        let valid = try JSONDecoder().decode(Rpc.self, from: validParameterString.data(using: .utf8)!)
        
        let resource = Resource<Web3Result<String>>(server: server, method: .clientVersion)
        let urlRequest = try URLRequest(resource: resource)
        
        // Decode body parameters and expected body parameters as Parameter struct so we can compare both
        guard let bodyData = urlRequest.httpBody else { throw UnexpectedNilError() }
        let body = try JSONDecoder().decode(Rpc.self, from: bodyData)
        
        XCTAssertNotEqual(invalid1, body, "1: \(invalid1) is equal to \(body)")
//        XCTAssertNotEqual(invalid2, body, "2: \(invalid2) is equal to \(body)")
        XCTAssertNotEqual(invalid3, body, "3: \(invalid3) is equal to \(body)")
        XCTAssertEqual(valid, body, "4: \(valid) is not equal to \(body)")
    }
    
    func endpoint(for method: NetworkMethod) throws {
        let resource = Resource<Web3Result<String>>(server: server, method: method)
        let urlRequest = try URLRequest(resource: resource)
        
        // Decode body parameters and expected body parameters as Parameter struct so we can compare both
        guard let bodyData = urlRequest.httpBody else { throw UnexpectedNilError() }
        print(String(data:bodyData, encoding: .utf8)!)
        let body = try JSONDecoder().decode(Rpc.self, from: bodyData)
        
        guard let expectedData = method.expectedBody.data(using: .utf8) else { throw UnexpectedNilError() }
        let expectedBody = try JSONDecoder().decode(Rpc.self, from: expectedData) // Parameter.self is the issue. Is it because Parameter is expecting [String]? instead of a dictionary? Changing it to Any -> Any is not conform codable. Perhaps changing it to JSONDictionary? Or enum?
        
        XCTAssertEqual(urlRequest.httpMethod, method.expectedHttpMethod, "Failed: httpMethod for \(String(describing: method)) is \(urlRequest.httpMethod ?? "nil")")
        XCTAssertEqual(urlRequest.url, URL(string: "http://localhost:8545"), "Failed: url for \(String(describing: method)) is \(String(describing: urlRequest.url))")
        let delta = body ∆ expectedBody
        XCTAssertNil(delta, "Failed: delta is not nil")
        XCTAssertEqual(body, expectedBody, "Failed: body and expectedBody are not equel. Delta: \(delta ?? "")")
    }
}
