//
//  ViewModelType.swift
//  Users
//
//  Created by Sven Svetina on 20/12/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
