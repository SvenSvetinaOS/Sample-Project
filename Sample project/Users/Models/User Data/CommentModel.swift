//
//  CommentModel.swift
//  Users
//
//  Created by Sven Svetina on 02/12/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct CommentModel {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    init(commentAPI: CommentAPI) {
        self.postId = commentAPI.postId
        self.id = commentAPI.id
        self.name = commentAPI.name
        self.email = commentAPI.email
        self.body = commentAPI.body
    }
}
