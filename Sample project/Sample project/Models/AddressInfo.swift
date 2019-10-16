//
//  AddressInfo.swift
//  Sample project
//
//  Created by Sven Svetina on 16/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

struct AddressInfo: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: GeoInfo
}
