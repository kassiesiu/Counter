//
//  DetailViewController.swift
//  Counter
//
//  Created by Kassie on 5/16/18.
//  Copyright © 2018 Kassie. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    var receivedCount: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    var receivedName: String?
    
    @IBOutlet weak var descLabel: UILabel!
    var receivedDesc: String?
    
    @IBOutlet weak var stepper: UIStepper!
    var receivedStepValue: Double?
    
    var receivedIndex: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        stepper.autorepeat = true
        stepper.maximumValue = 1000
        
        if let finalCount = receivedCount {
            countLabel.text = String(finalCount)
            stepper.value = Double(finalCount)
        }
        if let finalName = receivedName {
            nameLabel.text = String(finalName)
        }
        if let finalDesc = receivedDesc {
            descLabel.text = String(finalDesc)
        }
        if let finalStepValue = receivedStepValue {
            stepper.stepValue = finalStepValue
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        let count: Int = Int(sender.value)
        
        if (count == 1000) {
            countLabel.text = "1K"
        } else {
            countLabel.text = String(count)
        }
        updateCount()
    }
    
    func updateCount() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Counters")
        request.returnsObjectsAsFaults = false
        
        do {
            // result is all the objects inside Counter.xcdatamodeld
            // data is the current object we're working with (received via the indexPath from ViewController.swift
            // we set the value of the current object so that when we go back it will update in the main page
            let result = try context.fetch(request) as! [NSManagedObject]
            let data = result[receivedIndex!]
            
            data.setValue(Int64(countLabel.text!), forKey: "count")
            
            appDelegate.saveContext()
        } catch {
            print("error")
        }
    
    }

}
