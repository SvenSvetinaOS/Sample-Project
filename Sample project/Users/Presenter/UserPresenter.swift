//
//  UserPresenter.swift
//  Users
//
//  Created by Sven Svetina on 09/01/2020.
//  Copyright © 2020 Sven Svetina. All rights reserved.
//

class UserPresenter {
    
    var userUseCase: UserUseCaseProtocol!
    
    func getUser() -> User {
        return userUseCase.query()
    }
    
}
