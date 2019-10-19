//
//  Image.swift
//  Sample project
//
//  Created by Sven Svetina on 17/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct Photos: Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
