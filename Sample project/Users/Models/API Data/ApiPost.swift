//
//  Posts.swift
//  Sample project
//
//  Created by Sven Svetina on 28/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct ApiPost: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
