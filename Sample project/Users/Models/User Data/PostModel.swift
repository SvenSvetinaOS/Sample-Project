//
//  PostModel.swift
//  Users
//
//  Created by Sven Svetina on 29/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct PostModel {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    let commentModel: [CommentModel]
    
    init(postAPI: PostAPI, commentModel: [CommentModel]) {
        self.userId = postAPI.userId
        self.id = postAPI.id
        self.title = postAPI.title
        self.body = postAPI.body
        self.commentModel = commentModel
    }
}
