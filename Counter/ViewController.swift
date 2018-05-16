//
//  ViewController.swift
//  Counter
//
//  Created by Kassie on 5/15/18.
//  Copyright © 2018 Kassie. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {

    var counters : [Counters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Storing core data
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // get data from core data
        getData()
        
        //reload table
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as? CounterTableViewCell else {
//            fatalError("No.")
//        }
//
//        cell.countLabel.text = "3"
//        cell.nameLabel.text = "School end"
//        cell.descLabel.text = "School is ending!!!"
//
//        return cell
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as? CounterTableViewCell else {
            fatalError("No.")
        }
        
        let counter = counters[indexPath.row]
        cell.nameLabel.text = counter.name!

        return cell
        
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            counters = try context.fetch(Counters.fetchRequest())
        } catch {
            print("Fetching failed")
        }
    }


}

