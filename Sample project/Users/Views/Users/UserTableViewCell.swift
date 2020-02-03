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
import Kingfisher
import Alamofire

class UserTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: UserTableViewCell.self)
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var webLabel: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(model: UserModel, indexPath: IndexPath) {
        
        titleLabel.text = model.name
        phoneLabel.text = "Phone: \(model.phone)"
        webLabel.text = "Web: \(model.website)"
        let userImageString = model.albumModel[indexPath.section].photoModel.first!.url
        setImage(string: userImageString, imageView: userPhoto)
        
        titleLabel.sizeToFit()
        phoneLabel.sizeToFit()
        webLabel.sizeToFit()
    }
    
    func setImage(string: String, imageView: UIImageView) {
        let url = URL(string: string)
        let processor = DownsamplingImageProcessor(size: imageView.frame.size) |> RoundCornerImageProcessor(cornerRadius: 5)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
        ])
    }
}
