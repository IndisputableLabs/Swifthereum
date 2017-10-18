//
//  ViewController.swift
//  Swifthereum
//
//  Created by git on 10/09/2017.
//  Copyright (c) 2017 git. All rights reserved.
//

import UIKit
import BigInt
import Geth

class ViewController: UIViewController {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ethBalanceLabel: UILabel!
    @IBOutlet weak var transactionsLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var syncProgressLabel: UILabel!
    
    var node: Node?
    var client: EthereumClient?
    var syncTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNode()
        syncTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateSyncProgress), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        syncTimer?.fire()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        syncTimer?.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let qrViewController = segue.destination as? QRScannerViewController {
            qrViewController.delegate = self
        }
    }
    
    /// Start Ethereum node on device
    func startNode() {
        do {
            node = try Node(networkID: .main)
            try node?.start()
            client = try node?.ethereumClient()            
            if client == nil { errorLabel.text = "Could not start client" }
        } catch {
            errorLabel.text = error.localizedDescription
        }
    }
    
    @objc func updateSyncProgress() {
        guard let progress = client?.syncProgress() else {
            // Node is not syncing
            if let client = client, let block = try? client.block(byNumber: -1) {
                syncProgressLabel.text = "Node is not Syncing. Last block #\(block.number)"
            } else {
                syncProgressLabel.text = "Node is not Syncing"
            }
            return
        }
        syncProgressLabel.text = "Sync \(progress.percentage * 100)% complete"
    }
    
    func clearLabels() {
        addressLabel.text = ""
        ethBalanceLabel.text = ""
        transactionsLabel.text = ""
        messageLabel.text = ""
        errorLabel.text = ""
        syncProgressLabel.text = ""
    }
}

extension ViewController: QRCodeProtocol {
    func qrScanner(_ scanner: QRScannerViewController, didScan address: Address) {
        dismiss(animated: true){}
        addressLabel.text = address.description

        if let balance = try? client?.balance(for: address), let balanceString = balance?.formattedBalance(unit: .ether) {
            ethBalanceLabel.text = "\(balanceString.description) ETH"
        }
    }
    
    func qrScannerDidCancel(_ scanner: QRScannerViewController) {
        dismiss(animated: true){}
    }
}
