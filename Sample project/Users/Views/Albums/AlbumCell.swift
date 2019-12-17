//
//  AlbumCell.swift
//  Sample project
//
//  Created by Sven Svetina on 19/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation
import UIKit

class AlbumCell: UICollectionViewCell {
    
    static let identifier = String(describing: AlbumCell.self)
        
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
