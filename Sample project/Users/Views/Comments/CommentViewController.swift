//
//  CommentViewController.swift
//  Users
//
//  Created by Sven Svetina on 02/12/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var userModel = [UserModel]()
    var commentModelForUser = [CommentModel]()
    
    let tableView = UITableView()
    
    override func loadView() {
        super.loadView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "commentTableViewCell")
        tableView.reloadData()
        setupLayout()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModelForUser.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentTableViewCell") as! CommentTableViewCell
        cell.configureWithModel(commentModelForUser[indexPath.row])
        return cell
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        navigationItem.title = "Comments"
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}


