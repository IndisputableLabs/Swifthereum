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
    /*
    func testWeb3Endpoints() throws {
        try endpoint(for: .clientVersion)
        try endpoint(for: .sha3("0x68656c6c6f20776f726c64"))
    }
    
    func testNetEndpoints() throws {
        try endpoint(for: .networkID)
        try endpoint(for: .peerCount)
        try endpoint(for: .listening)        
    }
    
    func testEthEndpoints() throws {
        try endpoint(for: .protocolVersion)
        try endpoint(for: .isSyncing)
        try endpoint(for: .coinbase)
        try endpoint(for: .isMining)
        try endpoint(for: .hashrate)
        try endpoint(for: .gasPrice)
        try endpoint(for: .accounts)
        try endpoint(for: .blockNumber)
//        try endpoint(for: .balance())
        
        /*
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
    
    // SSH
    func testSshPost() throws { try endpoint(for: .sshPost) }
    func testSshVersion() throws { try endpoint(for: .sshVersion) }
    func testSshNewIdentity() throws { try endpoint(for: .sshNewIdentity) }
    func testSshHasIdentity() throws { try endpoint(for: .sshHasIdentity) }
    func testSshNewGroup() throws { try endpoint(for: .sshNewGroup) }
    func testSshAddToGroup() throws { try endpoint(for: .sshAddToGroup) }
    func testSshNewFilter() throws { try endpoint(for: .sshNewFilter) }
    func testSshUninstallFilter() throws { try endpoint(for: .sshUninstallFilter) }
    func testSshGetFilterChanges() throws { try endpoint(for: .sshGetFilterChanges) }
    func testSshGetMessages() throws { try endpoint(for: .sshGetMessages) }
    
    
    // test if error in a parameter dictionary is detected
    func testValidity() throws {
        
        let invalidParameterString = """
        {"jsonrpc":"2.0","method":"web3_invalidMethod","params":[],"id":67}
        """
        let invalidParameterString2 = """
        {"jsonrpc":"3.0","method":"web3_clientVersion","params":[],"id":67}
        """
        let invalidParameterString3 = """
        {"jsonrpc":"2.0","method":"web3_clientVersion","params":["invalidParameter"],"id":67}
        """        
        let validParameterString = """
        {"jsonrpc":"2.0","method":"web3_clientVersion","params":[],"id":2}
        """
        
        let invalid1 = try JSONDecoder().decode(Parameter.self, from: invalidParameterString.data(using: .utf8)!)
        let invalid2 = try JSONDecoder().decode(Parameter.self, from: invalidParameterString2.data(using: .utf8)!)
        let invalid3 = try JSONDecoder().decode(Parameter.self, from: invalidParameterString3.data(using: .utf8)!)
        let valid = try JSONDecoder().decode(Parameter.self, from: validParameterString.data(using: .utf8)!)
        
        let resource = Resource<Web3Result<String>>(server: server, method: .clientVersion)
        guard let urlRequest = URLRequest(resource: resource) else { throw UnexpectedNilError() }
        
        // Decode body parameters and expected body parameters as Parameter struct so we can compare both
        guard let bodyData = urlRequest.httpBody else { throw UnexpectedNilError() }
        let body = try JSONDecoder().decode(Parameter.self, from: bodyData)
        
        XCTAssertNotEqual(invalid1, body, "1: \(invalid1) is equal to \(body)")
        XCTAssertNotEqual(invalid2, body, "2: \(invalid2) is equal to \(body)")
        XCTAssertNotEqual(invalid3, body, "3: \(invalid3) is equal to \(body)")
        XCTAssertEqual(valid, body, "4: \(valid) is not equal to \(body)")
    }
    
    func endpoint(for method: NetworkMethod) throws {
        let resource = Resource<Web3Result<String>>(server: server, method: method)
        guard let urlRequest = URLRequest(resource: resource) else { throw UnexpectedNilError() }
        
        // Decode body parameters and expected body parameters as Parameter struct so we can compare both
        guard let bodyData = urlRequest.httpBody else { throw UnexpectedNilError() }
        let body = try JSONDecoder().decode(Parameter.self, from: bodyData)
        
        guard let expectedData = method.expectedBody.data(using: .utf8) else { throw UnexpectedNilError() }
        let expectedBody = try JSONDecoder().decode(Parameter.self, from: expectedData)
        
        XCTAssertEqual(urlRequest.httpMethod, method.expectedHttpMethod, "httpMethod for \(String(describing: method)) is \(urlRequest.httpMethod ?? "nil")")
        XCTAssertEqual(urlRequest.url, URL(string: "http://localhost:8545"), "url for \(String(describing: method)) is \(String(describing: urlRequest.url))")
        XCTAssertEqual(body, expectedBody, "body for \(String(describing: method)) is \(body)). Expected: \(method.expectedBody)")
    }
}








