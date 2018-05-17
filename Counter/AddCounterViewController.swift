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
    
    var count = 0
    
    @IBOutlet weak var nameText: UITextField! {
        didSet {
            nameText.textFieldPreferences()
        }
    }
    @IBOutlet weak var descText: UITextField! {
        didSet {
            descText.textFieldPreferences()
        }
    }
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepValuePicker: UISegmentedControl!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stepper.autorepeat = true
        stepper.maximumValue = 1000
        
        // MARK: How to enable/disable button
        // 1. Set button to isEnabled false
        // 2. addTargets
        // 3. make textFieldDidChange func
        saveButton.isEnabled = false // disable save button until fields have something in it
        nameText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange (_ textField:UITextField) {
        if let name = nameText.text {
            if !name.isEmpty {
                saveButton.isEnabled = true
            } else {
                saveButton.isEnabled = false
            }

        }
    }

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let counterItem = Counters(context: context)

        
        counterItem.name = nameText.text
        counterItem.count = Int64(countLabel.text!)!
        
        appDelegate.saveContext()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        var count: Int = Int(sender.value)
        let stepp: Int = Int(stepper.stepValue)
//        if Int(count) % stepp != 0, Int(count) / stepp != 1 {
//            count = count + (stepp - count)
//            countLabel.text = String(count)
//        } else {
//            countLabel.text = Int(sender.value).description
//        }
        
        if (stepp != 1) {
            count = count/stepp
            count = count * stepp
        }
        
        if (count == 1000) {
            countLabel.text = "1K"
        } else {
            countLabel.text = String(count)
        }
        
    }
    
    
    @IBAction func stepValueDecider(_ sender: UISegmentedControl) {
        switch stepValuePicker.selectedSegmentIndex {
        case 0:
            stepper.stepValue = 1
        case 1:
            stepper.stepValue = 10
        case 2:
            stepper.stepValue = 100
        default:
            break;
        }
    }

}

extension UITextField {
    func textFieldPreferences() {
        self.layer.masksToBounds = true

        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0).cgColor
        self.layer.borderWidth = 1
        
        // padding
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 15.0, height: 15.0))
        self.rightView = leftView
        self.leftView = leftView
        self.leftViewMode = .always
        self.rightViewMode = .always
        
        
    }
}
