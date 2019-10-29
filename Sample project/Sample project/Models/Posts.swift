//
//  Posts.swift
//  Sample project
//
//  Created by Sven Svetina on 28/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct Posts: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
