//
//  JSONTableViewCell.swift
//  placeHolderTabber
//
//  Created by Field Employee on 4/7/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit

class JSONTableViewCell: UITableViewCell {
 
    @IBOutlet weak var thumbImage: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var albumIdLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
