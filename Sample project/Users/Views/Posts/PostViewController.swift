//
//  PostViewController.swift
//  Users
//
//  Created by Sven Svetina on 29/11/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation

class PostViewController: UIViewController {
    private let cellHeight: CGFloat = 120.0
    let postTitle = "Posts"
    
    var users = [UserModel]()
    var postModelForUser = [PostModel]()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.loadView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: PostTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.reloadData()
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        navigationItem.title = postTitle
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }
}

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postModelForUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as! PostTableViewCell
        cell.configure(cellModel: postModelForUser[indexPath.row])
        return cell
    }
}

extension PostViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commentViewController = CommentViewController()
        let commentModelForUser = self.postModelForUser[indexPath.row].commentModel
        commentViewController.commentModelForUser = commentModelForUser
        
        navigationController?.pushViewController(commentViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

