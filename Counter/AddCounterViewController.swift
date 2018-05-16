//
//  AddCounterViewController.swift
//  Counter
//
//  Created by Kassie on 5/15/18.
//  Copyright © 2018 Kassie. All rights reserved.
//

import UIKit
import CoreData

class AddCounterViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var countText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // MARK: How to enable/disable button
        // 1. Set button to isEnabled false
        // 2. addTargets
        // 3. make textFieldDidChange func
        saveButton.isEnabled = false // disable save button until fields have something in it
        nameText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        countText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange (_ textField:UITextField) {
        if let name = nameText.text, let count = countText.text {
            if !name.isEmpty, !count.isEmpty {
                saveButton.isEnabled = true
            } else {
                saveButton.isEnabled = false
            }

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let counterItem = Counters(context: context)

        
        counterItem.name = nameText.text
        counterItem.count = Int64(countText.text!)!
        
        appDelegate.saveContext()
        self.dismiss(animated: true, completion: nil)
    }


}
