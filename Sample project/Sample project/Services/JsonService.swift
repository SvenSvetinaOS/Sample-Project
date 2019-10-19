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

enum jsonString: String {
    case users
    case photos
}

struct JsonService {
    let apiUrl: URL
    let photoUrl: URL
    var dataArray: [UserDetails] = []
    var photos: [Photos] = []
    
    init() {
        let APIString = "https://jsonplaceholder.typicode.com/users"
        let photosString = "https://jsonplaceholder.typicode.com/photos"
        
        guard let apiUrl = URL(string: APIString) else { fatalError() }
        self.apiUrl = apiUrl
        guard let photoUrl = URL(string: photosString) else { fatalError() }
        self.photoUrl = photoUrl
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
    
    func fetchPhotos(_ completion: @escaping (Result<[Photos], DataError>) -> Void) {
        
        
        let dataTask = URLSession.shared.dataTask(with: photoUrl) { (data, response, error) in
            guard let data = data else { completion (.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let details = try decoder.decode([Photos].self, from: data)
                completion(.success(details))
            } catch  {
                completion (.failure(.brokenAPI))
            }
            
        }
        dataTask.resume()
    }
}
