//
//  ViewController.swift
//  Sample project
//
//  Created by Sven Svetina on 10/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var networkService = NetworkService()
    var userModel = [UserModel]()
    var images: PhotoAPI!
    var user: UserAPI!
    var filteredPhotos = [String]()
    
    let tableView = UITableView()
    
    override func loadView() {
        super.loadView()
        setupLayout()
        
        networkService.fetchData() { [weak self] users in
            self?.userModel = users
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userTableViewCell")
            self?.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModel.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userTableViewCell") as! UserTableViewCell
        cell.configureWithCellModel(userModel[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumViewController = AlbumViewController()
        
        let albumModelForUser = userModel[indexPath.row].albumModel
        albumViewController.albumModelForUser = albumModelForUser
        let photoModelForUser = userModel[indexPath.section].albumModel[indexPath.row].photoModel
        albumViewController.photoModelForUser = photoModelForUser
        
        navigationController?.pushViewController(albumViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func setupLayout() {
        view.addSubview(tableView)
        navigationItem.title = "Users"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
