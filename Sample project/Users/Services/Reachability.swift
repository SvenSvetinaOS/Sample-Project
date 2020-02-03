//
//  Reachability.swift
//  Users
//
//  Created by Sven Svetina on 17/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation
import Alamofire

class Reachability {
     func isConnected() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
