//
//  UseCaseProvider.swift
//  Users
//
//  Created by Sven Svetina on 23/12/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

protocol UseCaseProvider {
    
    func makePostsUseCase() -> PostUseCase
    
}
