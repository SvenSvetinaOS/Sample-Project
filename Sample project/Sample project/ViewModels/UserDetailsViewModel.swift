//
//  UserDetailsViewModel.swift
//  Sample project
//
//  Created by Sven Svetina on 10/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

public class UserDetailsViewModel {
    
    private let userDetails: UserDetails
    private let addressInfo: AddressInfo
    private let geoInfo: GeoInfo
    private let companyInfo: CompanyInfo
    
    
    init(userDetails: UserDetails,
         addressInfo: AddressInfo,
         geoInfo: GeoInfo,
         companyInfo: CompanyInfo)
    {
        self.userDetails = userDetails
        self.addressInfo = addressInfo
        self.geoInfo = geoInfo
        self.companyInfo = companyInfo
    }
    public var id: Int {
        return userDetails.id
    }
    public var name: String {
        return userDetails.name
    }
    
       public var address: AddressInfo
      public var phone: String
       public var website: String
       var company: CompanyInfo
}
