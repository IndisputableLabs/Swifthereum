//
//  ViewController.swift
//  MacEtherScan
//
//  Created by Ronald Mannak on 10/18/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import Cocoa
import Swifthereum
import BigInt

// geth --rpc
// testrpc
// infura


class ViewController: NSViewController {
    
//    let swifthereum = Swifthereum(provider: .web3(server: Server(domain: "https://mainnet.infura.io/mwHd0j5tlQUZ9zx3Lkv5")))
    let swifthereum = Swifthereum(provider: .web3(server: Server()))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getBalance()
//        getTransaction()
//        testAPI()
    }
    
    func getBalance() {
        let address = Address(hex:"0x3914bff975ef35e8d3403e1ea953bf886b0e8fea")!
        print(address)
        address.balance(swifthereum: swifthereum) { result in
            switch result {
            case .data(let balance):
                print(BigInt(balance.remove0xPrefix(), radix: 16))
            default:
                break
            }
            
        }
    }
    
    func getTransaction() {
        let transaction = TransactionHash(hex: "0x7f853aea006cf7eb1f06b6aefcb1049a48a49bd93a0ae70e7e85b7b284d7662b")!
        transaction.transaction(swifthereum: swifthereum) { result in
            print(result)
        }
    }
    
    func testAPI() {
        /*
        case clientVersion OK
        case sha3(String)
        
        // Net
        case version
        case peerCount
        case listening
        */
//        let address = Address(hex:"0x3914bff975ef35e8d3403e1ea953bf886b0e8fea")!
        let transaction = TransactionHash(hex: "0x7f853aea006cf7eb1f06b6aefcb1049a48a49bd93a0ae70e7e85b7b284d7662b")!
        let method = Method.transactionByHash(transaction)  //balance(address, .latest)
        swifthereum.fetch(method: method) { (result: Result<Transaction>) in
            print (result)
        }
    }

}

