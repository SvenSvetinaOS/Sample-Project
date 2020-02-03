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
    var postModel: [PostModel]
    
    init(userAPI: ApiUser, albumModel: [AlbumModel], postModel: [PostModel]) {
        self.id = userAPI.id
        self.name = userAPI.name
        self.phone = userAPI.phone
        self.website = userAPI.website
        self.albumModel = albumModel
        self.postModel = postModel
    }
    
    init(user: User) {
        self.id = user.userId
        self.name = user.name
        self.phone = user.phone
        self.website = user.website
        self.albumModel = []
        self.postModel = []
    }
    
}
