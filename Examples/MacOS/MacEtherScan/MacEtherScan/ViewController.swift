//
//  ViewController.swift
//  MacEtherScan
//
//  Created by Ronald Mannak on 10/18/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Cocoa
import Swifthereum

// geth --rpc
// testrpc
// infura


class ViewController: NSViewController {
    
    let swifthereum = Swifthereum(provider: .web3(server: Server()))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBalance()
//        testMethods()
        
//        networkTest()
        // Do any additional setup after loading the view.
        
//        let hash = Hash()
//
//        guard let address = AddressHash(hex: "0x3914bff975ef35e8d3403e1ea953bf886b0e8fea") else {
//            print("nil")
//            return
//        }
//        print (address)
        
        
        // https://github.com/ethereum/wiki/wiki/JSON-RPC#net_version
    }
    

    func testMethods() {
        guard let address = Address(hex: "0x3914bff975ef35e8d3403e1ea953bf886b0e8fea") else { fatalError() }
        let method = Method.balance(address, .latest)
        let resource = Resource<Web3Result>(server: Server(), method: method)
        NetworkService().load(resource: resource, debug: false) { result in
            print("result: \(result)")
        }
    }
    
    func getBalance() {
        let address: Address = Address(hex:"0x3914bff975ef35e8d3403e1ea953bf886b0e8fea")!
        print(address)
        address.balance(swifthereum: swifthereum) { result in
            print(result)
        }
    }
    //web3_clientVersion
    func networkTest() {
        let server = Server()
        let resource = Resource<Web3Result>(server: server, method: "web3_clientVersion", parameters: nil, headers: nil, httpMethod: .post, encoding: .json)
        NetworkService().load(resource: resource, debug: true) { result in
            print("load ended with result: \(result)")
        }
    }

}

