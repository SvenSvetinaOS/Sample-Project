//
//  AlbumModel.swift
//  Sample project
//
//  Created by Sven Svetina on 12/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct AlbumModel {
    let id: Int
    let title: String
    let photoModel: [PhotoModel]
   
    init(albumAPI: AlbumAPI, photoModel: [PhotoModel]) {
        self.id = albumAPI.id
        self.title = albumAPI.title
        self.photoModel = photoModel
    }
}
