//
//  Paths.swift
//  Users
//
//  Created by Sven Svetina on 28/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

enum ResourcePaths: String {
    case users = "users"
    case albums = "albums"
    case photos = "photos"
    case posts = "posts"
    case comments = "comments"
    
    func path() -> String {
        return "https://jsonplaceholder.typicode.com/\(self.rawValue)"
    }
}
