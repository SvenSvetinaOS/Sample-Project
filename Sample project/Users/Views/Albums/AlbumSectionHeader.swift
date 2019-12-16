//
//  AlbumSectionHeader.swift
//  Sample project
//
//  Created by Sven Svetina on 21/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit

class AlbumSectionHeader: UICollectionReusableView {
    
    static let identifier = String(describing: AlbumSectionHeader.self)

    @IBOutlet weak var albumName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(cellModel: [AlbumModel], indexPath: IndexPath) {
        albumName.text = cellModel[indexPath.section].title.capitalized
        albumName.sizeToFit()
    }
}
