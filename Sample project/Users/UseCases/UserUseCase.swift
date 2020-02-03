//
//  UserUseCase.swift
//  Users
//
//  Created by Sven Svetina on 08/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

import Foundation

class UserUseCase: UserUseCaseProtocol {
    
    private var userRepository: UserRepositoryProtocol!
    
    init(userRepository: UserRepositoryProtocol) {
        self.userRepository = userRepository
    }
    
    func queryUsers(completion: @escaping ([UserModel]) -> Void) {
        userRepository.getUsers(completion: completion)
    }
}

