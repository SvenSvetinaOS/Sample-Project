//
//  Comments.swift
//  Sample project
//
//  Created by Sven Svetina on 29/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct ApiComment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
