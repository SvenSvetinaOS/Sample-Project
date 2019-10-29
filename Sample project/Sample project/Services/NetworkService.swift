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

class NetworkService {
    
    let apiUrl: URL
    let photoUrl: URL
    let postsUrl: URL
    let commentsUrl: URL
    let albumsUrl: URL
    var users = [Users]()
    var photos = [Photos]()
    var posts = [Posts]()
    var comments = [Comments]()
    var albums = [Albums]()
    
    init() {
        let APIString = "https://jsonplaceholder.typicode.com/users"
        let photosString = "https://jsonplaceholder.typicode.com/photos"
        let postsString = "https://jsonplaceholder.typicode.com/posts"
        let commentsString = "https://jsonplaceholder.typicode.com/comments"
        let albumsString = "https://jsonplaceholder.typicode.com/albums"
        
        guard let apiUrl = URL(string: APIString) else { fatalError() }
        self.apiUrl = apiUrl
        guard let photoUrl = URL(string: photosString) else { fatalError() }
        self.photoUrl = photoUrl
        guard let postsUrl = URL(string: postsString) else { fatalError() }
        self.postsUrl = postsUrl
        guard let commentsUrl = URL(string: commentsString) else { fatalError() }
        self.commentsUrl = commentsUrl
        guard let albumsUrl = URL(string: albumsString) else { fatalError() }
        self.albumsUrl = albumsUrl
    }
    
    func fetchUsers(_ completion: @escaping (Result<[Users], DataError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            guard let data = data else { completion (.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let details = try decoder.decode([Users].self, from: data)
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
    
    func fetchPosts(_ completion: @escaping (Result<[Posts], DataError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: postsUrl) { (data, response, error) in
            guard let data = data else { completion (.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let details = try decoder.decode([Posts].self, from: data)
                completion(.success(details))
            } catch  {
                completion (.failure(.brokenAPI))
            }
        }
        dataTask.resume()
    }
    func fetchComments(_ completion: @escaping (Result<[Comments], DataError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: commentsUrl) { (data, response, error) in
            guard let data = data else { completion (.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let details = try decoder.decode([Comments].self, from: data)
                completion(.success(details))
            } catch  {
                completion (.failure(.brokenAPI))
            }
        }
        dataTask.resume()
    }
    
    func fetchAlbums(_ completion: @escaping (Result<[Albums], DataError>) -> Void) {
         let dataTask = URLSession.shared.dataTask(with: albumsUrl) { (data, response, error) in
             guard let data = data else { completion (.failure(.invalidData))
                 return
             }
             do {
                 let decoder = JSONDecoder()
                 let details = try decoder.decode([Albums].self, from: data)
                 completion(.success(details))
             } catch  {
                 completion (.failure(.brokenAPI))
             }
         }
         dataTask.resume()
     }
    
    func fetchAllData() {
        fetchUsers() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self?.users = data
                }
            }
        }
        fetchPhotos { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let photoData):
                    self?.photos = photoData
                }
            }
        }
        fetchPosts() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let postData):
                    self?.posts = postData
                }
            }
        }
        fetchComments() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self?.comments = data
                }
            }
        }
        fetchAlbums() { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self?.albums = data
                }
            }
        }
    }
}

