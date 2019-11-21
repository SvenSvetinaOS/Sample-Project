//
//  UserModel.swift
//  Sample project
//
//  Created by Sven Svetina on 12/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct UserModel {
    let id: Int
    let name: String
    let phone: String
    let website: String
    var albumModel: [AlbumModel]
    
    init(userAPI: UserAPI, albumModel: [AlbumModel]) {
        self.id = userAPI.id
        self.name = userAPI.name
        self.phone = userAPI.phone
        self.website = userAPI.website
        self.albumModel = albumModel
    }
}
