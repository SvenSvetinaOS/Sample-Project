//
//  Comments.swift
//  Sample project
//
//  Created by Sven Svetina on 29/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct Comments: Codable {
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}
