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

        do {
            try getBalance()
            try getTransaction()
            try getAccounts()
            try testParameters()
            try gasPrice()
        } catch {
            print(error)
        }
    }
    
    func getBalance() throws {
        let address = Address(hex:"0xb81df5747f39bfd5ce9410f1be9b02851b0cbd6e")!
        print(address)
        try address.balance(swifthereum: swifthereum) { result in
            switch result {
            case .data(let balance):
                print("Balance: \(balance.formattedBalance(unit: .ether)) Ether")
                //print(BigInt(balance.remove0xPrefix(), radix: 16)!)
            default:
                break
            }
            
        }
    }
    
    func getTransaction() throws {
        let transaction = TransactionHash(hex: "0x7f853aea006cf7eb1f06b6aefcb1049a48a49bd93a0ae70e7e85b7b284d7662b")!
        try transaction.transaction(swifthereum: swifthereum) { result in
            print(result)
        }
    }
    
    func gasPrice() throws {
        try self.swifthereum.gasPrice(completion: { (result) in
            switch result {
            case .data(let wei):
                let gasPrice = wei.formattedBalance(unit: .gwei)
                print("gas price: \(gasPrice) gwei")
//                self.getAccounts()
            default: fatalError()
            }
        })
    }
    
    func getAccounts() throws {
        try swifthereum.accounts { result in
    
            switch result {
            case .data(let accounts):
                print(accounts)
//                guard let firstAccount = accounts.first else { fatalError() }
//                let secondAccount = accounts[2]
//
//                self.swifthereum.gasPrice(completion: { (result) in
//                    switch result {
//                    case .data(let weiString):
//                        print("gas price: \(weiString) ETH")
////                        let estTransaction = NewTransaction(from: firstAccount, to: secondAccount, gasPrice: gasPrice)
////
////                        self.swifthereum.estimateGas(for: <#T##NewTransaction#>, completion: <#T##(Result<String>) -> ()#>)
//                    default: fatalError()
//                    }
//                })
                
                
                
                
//                let transaction = NewTransaction(
//                public let from: Address?
//                public let to: Address
//                public let gas: Wei?
//                public let gasPrice: Wei?
//                public let value: HashString?
//                public let data: String?
//                public let nonce: Int?
//                )
//                print("Account: \(firstAccount)")
//
                
            default:
                fatalError()
            }
        }
    }
//
    func testParameters() throws {
        
        try swifthereum.balance(for: Address(hex: "0xb81df5747f39bfd5ce9410f1be9b02851b0cbd6e")!) { result in
            print("result")
        }
        
        /*
         case .balance(let address, let defaultBlock):
        return [String(describing: address), defaultBlock.value]
        case .storage(let address, let defaultBlock):
        return [String(describing: address), defaultBlock.value]
        case .transactionCount(let address, let defaultBlock):
        return [String(describing: address), defaultBlock.value]
        case .blockTransactionCount(let blockHash):
        return String(describing: blockHash)
        case .blockTransactionCountByNumber(let number):
        return "\(number)"
        case .uncleCount(let blockHash):
        return String(describing: blockHash)
        case .uncleCountByBlockNumber(let number):
        return "\(number)"
         */
    }

}

