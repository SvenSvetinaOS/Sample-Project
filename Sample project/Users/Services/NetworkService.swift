//
//  JsonService.swift
//  Sample project
//
//  Created by Sven Svetina on 25/09/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import Foundation
import CoreData

class NetworkService {
    var users = [UserAPI]()
    var photos = [PhotoAPI]()
    var posts = [PostAPI]()
    var comments = [CommentAPI]()
    var albums = [AlbumAPI]()
    let dispatchGroup = DispatchGroup()
    var userModel: UserModel!
    var managedUsers = [User]()
    
    var userStore = UserStore()
//    
    init() {
        self.userStore = UserStore()
    }
    
    func fetchData(completion: @escaping ([UserModel]) -> Void) {
        dispatchGroup.enter()
        let userResource: Resources<UserAPI> = Resources(path: ResourcePaths.users.path())
        userResource.fetchResourceData { [weak self] user in
            self?.users = user
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        let albumResource: Resources<AlbumAPI> = Resources(path: ResourcePaths.albums.path())
        albumResource.fetchResourceData { [weak self] album in
            self?.albums = album
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        let photoResource: Resources<PhotoAPI> = Resources(path: ResourcePaths.photos.path())
        photoResource.fetchResourceData { [weak self] photo in
            self?.photos = photo
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        let postResource: Resources<PostAPI> = Resources(path: ResourcePaths.posts.path())
        postResource.fetchResourceData { [weak self] post in
            self?.posts = post
            self?.dispatchGroup.leave()
        }
        dispatchGroup.enter()
        let commentResource: Resources<CommentAPI> = Resources(path: ResourcePaths.comments.path())
        commentResource.fetchResourceData { [weak self] comment in
            self?.comments = comment
            self?.dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main, execute: {
            let userModels = self.createUsers(users: self.users, albums: self.albums, photos: self.photos, posts: self.posts, comments: self.comments)
            completion(userModels)
        })
        let test = userStore.query()
    }
    
    func createUsers(users: [UserAPI], albums: [AlbumAPI], photos: [PhotoAPI], posts: [PostAPI], comments: [CommentAPI]) -> [UserModel] {
        var photosByAlbumId = [Int: [PhotoModel]]()
        var albumsByUserId = [Int : [AlbumModel]]()
        var commentsByPostId = [Int: [CommentModel]]()
        var postsByUserId = [Int : [PostModel]]()
        var userModels = [UserModel]()
        
        for comment in comments {
            var commentsArray = commentsByPostId[comment.postId, default: [CommentModel]()]
            commentsArray.append(CommentModel(commentAPI: comment))
            commentsByPostId[comment.postId] = commentsArray
        }
        
        for post in posts {
            var postsArray = postsByUserId[post.userId, default: [PostModel]()]
            postsArray.append(PostModel(postAPI: post, commentModel: commentsByPostId[post.id]!))
            postsByUserId[post.userId] = postsArray
        }
    
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
            let userModel = UserModel(userAPI: user, albumModel: albumsByUserId[user.id]!, postModel: postsByUserId[user.id]!)
            userModels.append(userModel)
            self.userModel = userModel
            let uzr = userStore.save(userModel: userModel)
            managedUsers.append(uzr)
        }
        return userModels
    }
}
