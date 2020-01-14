//
//  PhotoCell.swift
//  Sample project
//
//  Created by Sven Svetina on 07/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {
    
    static var identifier = String(describing: self)
    
    @IBOutlet weak var photoImageView: UIImageView!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
