//
//  JsonService.swift
//  Sample project
//
//  Created by Sven Svetina on 25/09/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

enum DataError: Error {
    case invalidData
    case brokenAPI
}

struct JsonService {
    let apiUrl: URL
    var dataArray: [UserDetails] = []
    
    init() {
        let APIString = "https://jsonplaceholder.typicode.com/users"
        
        guard let apiUrl = URL(string: APIString) else { fatalError() }
        self.apiUrl = apiUrl
    }
    
    func fetchData(_ completion: @escaping (Result<[UserDetails], DataError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            guard let data = data else { completion (.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let details = try decoder.decode([UserDetails].self, from: data)
                completion(.success(details))
            } catch  {
                completion (.failure(.brokenAPI))
            }
            
        }
        dataTask.resume()
    }
}
