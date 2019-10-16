//
//  JsonData.swift
//  Sample project
//
//  Created by Sven Svetina on 25/09/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

public struct UserDetails: Codable {
    var id: Int
    var name: String
    var address: AddressInfo
    var phone: String
    var website: String
    var company: CompanyInfo
}
