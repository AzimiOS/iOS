//
//  TableViewCell.swift
//  api call
//
//  Created by Apple on 10/03/18.
//  Copyright © 2018 Azim. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var dateDAy: UILabel!
    @IBOutlet weak var cview: UIView!
    
    @IBOutlet weak var Day: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
