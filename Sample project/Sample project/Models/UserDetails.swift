//
//  JsonData.swift
//  Sample project
//
//  Created by Sven Svetina on 25/09/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

public struct UserDetails: Decodable {
    var id: Int
    var name: String
    var address: AddressInfo
    var phone: String
    var website: String
    var company: CompanyInfo
}

struct AddressInfo: Decodable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: GeoInfo
}

struct GeoInfo: Decodable {
    var lat: String
    var lng: String
}

struct CompanyInfo: Decodable {
    var name: String
}
