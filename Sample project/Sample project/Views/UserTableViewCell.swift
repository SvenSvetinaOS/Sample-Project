//
//  UserTableViewCell.swift
//  Sample project
//
//  Created by Sven Svetina on 28/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var webLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureWithCellModel(_ cellModel: UserModel) {
        titleLabel.text = cellModel.name
        phoneLabel.text = "Phone: \(cellModel.phone)"
        webLabel.text = "Web: \(cellModel.website)"
        titleLabel.sizeToFit()
        phoneLabel.sizeToFit()
        webLabel.sizeToFit()
    }
}
