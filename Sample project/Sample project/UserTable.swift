//
//  UserTable.swift
//  Sample project
//
//  Created by Sven Svetina on 01/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import PureLayout

class UserTable: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
