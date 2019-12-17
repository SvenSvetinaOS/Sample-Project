//
//  JsonData.swift
//  Sample project
//
//  Created by Sven Svetina on 25/09/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct UserAPI: Codable {
    let id: Int
    let name: String
    let phone: String
    let website: String
}
