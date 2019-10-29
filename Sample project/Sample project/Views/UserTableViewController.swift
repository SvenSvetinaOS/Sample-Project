//
//  ViewController.swift
//  Sample project
//
//  Created by Sven Svetina on 10/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation

class UserTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var networkService = NetworkService()
    var images: Photos!
    var user: Users!
    
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func loadButtonTapped(_ sender: Any) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "userTableViewCell")
        networkService.fetchAllData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkService.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "userTableViewCell") as! UserTableViewCell
        let user = networkService.users[indexPath.row]
        
        cell.titleLabel.text = user.name
        cell.titleLabel.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = "Users"
        
        return title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = networkService.users[indexPath.row]
        
        let userViewController = UserViewController()
        
        present(userViewController, animated: true, completion: nil)
        
        userViewController.nameLabel.text = user.name
        userViewController.phoneLabel?.text = user.phone
        
        let photoURL = URL(string: networkService.photos.first?.url ?? "")
        let photoData = try? Data(contentsOf: photoURL!)
        let image = UIImage(data: photoData!)
        userViewController.userImage.image = image
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
