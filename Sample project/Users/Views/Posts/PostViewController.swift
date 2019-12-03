//
//  PostViewController.swift
//  Users
//
//  Created by Sven Svetina on 29/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation

class PostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var userModel = [UserModel]()
    var postModelForUser = [PostModel]()
    
    let tableView = UITableView()
    
    override func loadView() {
        super.loadView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postTableViewCell")
        tableView.reloadData()
        setupLayout()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModelForUser.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postTableViewCell") as! PostTableViewCell
        cell.configureWithModel(postModelForUser[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentViewController = CommentViewController()
        let commentModelForUser = self.postModelForUser[indexPath.row].commentModel
        commentViewController.commentModelForUser = commentModelForUser
        
        navigationController?.pushViewController(commentViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        navigationItem.title = "Posts"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

