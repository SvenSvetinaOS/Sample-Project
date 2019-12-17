//
//  CommentTableViewCell.swift
//  Users
//
//  Created by Sven Svetina on 02/12/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CommentTableViewCell.self)

    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(cellModel: CommentModel) {
        commentName.text = cellModel.name
        commentBody.text = cellModel.body
        commentName.sizeToFit()
        commentBody.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
