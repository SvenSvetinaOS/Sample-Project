//
//  Resources.swift
//  Sample project
//
//  Created by Sven Svetina on 11/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

public struct Resources<T: Decodable> {
    let path: String
    
    public func fetchResourceData(completion: @escaping ([T]) -> Void) {
        guard let url = URL(string: path)  else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error.debugDescription)
            }
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode([T].self, from: data)
                completion(result)
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
