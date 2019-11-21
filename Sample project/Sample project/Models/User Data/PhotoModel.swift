//
//  PhotoModel.swift
//  Sample project
//
//  Created by Sven Svetina on 12/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct PhotoModel {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    
    init(photoAPI: PhotoAPI) {
        self.albumId = photoAPI.albumId
        self.id = photoAPI.id
        self.title = photoAPI.title
        self.url = photoAPI.url
        self.thumbnailUrl = photoAPI.thumbnailUrl
    }
}
