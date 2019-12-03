//
//  AlbumSectionHeader.swift
//  Sample project
//
//  Created by Sven Svetina on 21/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit

class AlbumSectionHeader: UICollectionReusableView {

    @IBOutlet weak var albumName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWithModel(_ cellModel: [AlbumModel], _ indexPath: IndexPath) {
        albumName.text = cellModel[indexPath.section].title.capitalized
        albumName.sizeToFit()
        albumName.autoCenterInSuperview()
    }
    
}
