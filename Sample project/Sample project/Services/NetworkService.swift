//
//  JsonService.swift
//  Sample project
//
//  Created by Sven Svetina on 25/09/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation

class NetworkService {
    
    var users = [UserAPI]()
    var photos = [PhotoAPI]()
    var posts = [PostAPI]()
    var comments = [CommentAPI]()
    var albums = [AlbumAPI]()
    let dispatchGroup = DispatchGroup()
    var userModel: UserModel!
    
    let usersString = "https://jsonplaceholder.typicode.com/users"
    let photosString = "https://jsonplaceholder.typicode.com/photos"
    let postsString = "https://jsonplaceholder.typicode.com/posts"
    let commentsString = "https://jsonplaceholder.typicode.com/comments"
    let albumsString = "https://jsonplaceholder.typicode.com/albums"
    
    func fetchData(completion: @escaping ([UserModel]) -> Void) {
        dispatchGroup.enter()
        let userResource: Resources<UserAPI> = Resources(path: usersString)
        userResource.fetchResourceData { [weak self] user in
            self?.users = user
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        let albumResource: Resources<AlbumAPI> = Resources(path: albumsString)
        albumResource.fetchResourceData { [weak self] album in
            self?.albums = album
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        let photoResource: Resources<PhotoAPI> = Resources(path: photosString)
        photoResource.fetchResourceData { [weak self] photo in
            self?.photos = photo
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        let postResource: Resources<PostAPI> = Resources(path: postsString)
        postResource.fetchResourceData { [weak self] post in
            self?.posts = post
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        let commentResource: Resources<CommentAPI> = Resources(path: commentsString)
        commentResource.fetchResourceData { [weak self] comment in
            self?.comments = comment
            self?.dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main, execute: {
            let userModels = self.createUsers(users: self.users, albums: self.albums, photos: self.photos)
            completion(userModels)
        })
    }
    
    func createUsers(users: [UserAPI], albums: [AlbumAPI], photos: [PhotoAPI]) -> [UserModel] {
        var photosByAlbumId = [Int: [PhotoModel]]()
        var albumsByUserId = [Int : [AlbumModel]]()
        var userModels = [UserModel]()
    
        for photo in photos {
            var photosArray = photosByAlbumId[photo.albumId, default: [PhotoModel]()]
            photosArray.append(PhotoModel(photoAPI: photo))
            photosByAlbumId[photo.albumId] = photosArray
        }
        
        for album in albums {
            var albumsArray = albumsByUserId[album.userId, default: [AlbumModel]()]
            albumsArray.append(AlbumModel(albumAPI: album, photoModel: photosByAlbumId[album.id]!))
            albumsByUserId[album.userId] = albumsArray
        }
        
        for user in users {
            let userModel = UserModel(userAPI: user, albumModel: albumsByUserId[user.id]!)
            userModels.append(userModel)
        }
        return userModels
    }
}
