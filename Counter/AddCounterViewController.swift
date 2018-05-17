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
    var pickerData: [String] = [String]()
//    var textFields = [UITextField]()
    
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
    @IBOutlet weak var incDecPicker: UIPickerView!
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        stepper.autorepeat = true
        
        pickerData = ["Increasing", "Decreasing"]

        
        // MARK: How to enable/disable button
        // 1. Set button to isEnabled false
        // 2. addTargets
        // 3. make textFieldDidChange func
        saveButton.isEnabled = false // disable save button until fields have something in it
        nameText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
//        countText.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
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
        countLabel.text = Int(sender.value).description
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
