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
    
    // MARK: SET UP CELLS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as? CounterTableViewCell else {
            fatalError("No.")
        }
        
        let counter = counters[indexPath.row]
        cell.nameLabel.text = counter.name!
        cell.countLabel.text = String(counter.count)

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
    
    // MARK: EDIT CELLS
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // delete
            print("Delete")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let commit = counters[indexPath.row]
            
            appDelegate.persistentContainer.viewContext.delete(commit)

            counters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            appDelegate.saveContext()
            
        }
    }
    


}

