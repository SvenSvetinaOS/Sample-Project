//
//  PostTableViewCell.swift
//  Users
//
//  Created by Sven Svetina on 29/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWithModel(_ cellModel: PostModel) {
        postTitle.text = cellModel.title
        postBody.text = cellModel.body
        postTitle.sizeToFit()
        postBody.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
