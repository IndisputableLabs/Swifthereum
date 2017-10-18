//
//  MasterViewController.swift
//  GethExample
//
//  Created by Ronald Mannak on 10/11/17.
//  Copyright © 2017 Indisputable Labs. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Any]()

    var node: Node!
    var client: EthereumClient!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        startNode()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    func nodeInfo() {
//        clearLabels()
        do {
//            label1.text = "Node name: \(node.name) at \(node.listenerAddress)"
//            label2.text = "Protocols: \(node.protocols)"
            var nodes = ""
            for node in try node.peersInfo() {
                nodes = nodes + node.remoteAddress + "(" + node.name + "), "
            }
//            label3.text = nodes
        } catch {
            print(error)
        }
    }
    
    func accountInfo() {
//        clearLabels()
        
        let address = try! Address(hex: "0x472250f44556F042E64Af5006fAb9BDb1D9e39fE")  // "0x548429264DAcf79e7c96aC00D3d12760922d4c31") // Main net
        //        let address = try! Address(hex: "0xb81Df5747f39bfD5ce9410F1Be9B02851B0cbd6E") // Rinkeby
        
        do {
            let peers = try node.peersInfo()
            
            print("** peers: \(peers)")
            print("** ip: \(node.ipAddress)")
            print("** listenener: \(node.listenerAddress)")
            print("** listenerPort: \(node.listenerPort)")
            print("** name: \(node.name)")
            print("** protocols: \(node.protocols)")
            
            // Prints latest known block
            let block = try client.block(byNumber: -1)
            print("*** Latest block: \(block.number)")
//            label3.text = "Latest block: \(block.number) (\(block.txHash.hex))"
            
            let balance = try client.balance(for: address, block: -1)
            //            print("***: Balance: \(balance) Wei \(balance.converted(to: .ether)) ETH")
            //            label1.text = "Balance: \(balance) Wei \(balance.converted(to: .ether)) ETH"
        } catch {
            print("****: \(error)")
        }
        
        do {
            let b2 = try client.pendingBalance(account: address)
            print("*** B2: \(b2)")
//            label2.text = "Pending: \(b2)"
        } catch {
            print("****: \(error)")
        }
    }
    
    func progressInfo()  {
//        clearLabels()
        
        guard let progress = client.syncProgress() else { return }
        
//        label1.text = "S: \(progress.startingBlock) C: \(progress.currentBlock) / of \(progress.highestBlock)"
//        label2.text = "\(progress.knownStates) known states / \(progress.pulledStates) pulled"
//        label3.text = "\(progress.percentage * 100)%"
    }
    
    func startNode() {
        
        do {
            node = try Node(networkID: .main)
            try node.start()
            client = try node.ethereumClient()
            
            assert(node != nil, "node is nil")
            assert(client != nil, "client is nil")
            
        } catch {
            print(error)
            fatalError()
        }
    }

}

