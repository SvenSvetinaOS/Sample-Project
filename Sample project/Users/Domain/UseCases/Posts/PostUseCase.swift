//
//  PostUseCase.swift
//  Users
//
//  Created by Sven Svetina on 23/12/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

public protocol PostUseCase {
    
    func posts() -> PostModel
    func save(post: PostModel) -> Void
    func delete(post: PostModel) -> Void
    
}
