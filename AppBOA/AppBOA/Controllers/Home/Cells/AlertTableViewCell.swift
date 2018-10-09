//
//  AlertTableViewCell.swift
//  AppBOA
//
//  Created by Danitza on 10/8/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import UIKit
import Foundation

class AlertTableViewCell: UITableViewCell{
    
    @IBOutlet weak var typeAlertNameLabel: UILabel!
    
    @IBOutlet weak var titleAlertNameLabel: UILabel!
    
    @IBOutlet weak var descriptionAlertNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
