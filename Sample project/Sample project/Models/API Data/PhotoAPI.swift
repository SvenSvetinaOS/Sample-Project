//
//  Image.swift
//  Sample project
//
//  Created by Sven Svetina on 17/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct PhotoAPI: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
