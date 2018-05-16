//
//  CounterTableViewCell.swift
//  Counter
//
//  Created by Kassie on 5/15/18.
//  Copyright © 2018 Kassie. All rights reserved.
//

import UIKit

class CounterTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
