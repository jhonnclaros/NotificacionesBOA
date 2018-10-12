//
//  AlertApproveTableViewCell.swift
//  AppBOA
//
//  Created by Danitza on 10/11/18.
//  Copyright © 2018 BOA. All rights reserved.
//

import UIKit
import Foundation

class AlertApproveTableViewCell: UITableViewCell{

    @IBOutlet weak var typeAlertLabel: UILabel!
    
    @IBOutlet weak var titleAlertLabel: UILabel!
    
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    
    @IBOutlet weak var longDescriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
