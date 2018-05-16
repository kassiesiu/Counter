//
//  ViewController.swift
//  Counter
//
//  Created by Kassie on 5/15/18.
//  Copyright © 2018 Kassie. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "counterCell", for: indexPath) as? CounterTableViewCell else {
            fatalError("No.")
        }
        
        cell.countLabel.text = "3"
        cell.nameLabel.text = "School end"
        cell.descLabel.text = "School is ending!!!"
        
        return cell
        
    }


}

