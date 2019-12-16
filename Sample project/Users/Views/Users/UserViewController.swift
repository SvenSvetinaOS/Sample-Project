//
//  ViewController.swift
//  Sample project
//
//  Created by Sven Svetina on 10/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation

class UserViewController: UIViewController {
    private let cellHeight: CGFloat = 120.0
    let usersTitle = "Users"
    let loading = "Loading"
    let search = "Searing Users"
    let albums = "Albums"
    let posts = "Posts"
    let delete = "Delete"
    
    var networkService = NetworkService()
    var users = [UserModel]()
    var filteredUsers = [UserModel]()
    var refreshControl = UIRefreshControl()
    let searchController = UISearchController(searchResultsController: nil)
    
    let tableView = UITableView()
    let tableHeader = UITableViewHeaderFooterView()
        
    override func viewDidLoad() {
        super.loadView()
        setupTableView()
        setupLayout()
        setupSearch()
        fetchData()
    }
    
    func setupTableView() {
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: UserTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UserTableViewCell.identifier)
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        navigationItem.title = usersTitle
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        tableView.keyboardDismissMode = .onDrag
        
        refreshControl.attributedTitle = NSAttributedString(string: loading)
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func fetchData() {
        networkService.fetchData() { [weak self] users in
            self?.users = users
            self?.filteredUsers = users
            self?.refreshControl.endRefreshing()
            self?.tableView.reloadData()
        }
    }
    
    func filterContent(searchText: String?) {
        if let searchText = searchText, !searchText.isEmpty {
            filteredUsers = users.filter { user in
                return user.name.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredUsers = users
        }
        tableView.reloadData()
    }
    
    @objc func refreshTableView() {
        fetchData()
    }
}

// MARK: UISearchControllerDelegate
extension UserViewController: UISearchControllerDelegate {
    
    func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = search
        searchController.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
}
// MARK: UISearchResultsUpdating
extension UserViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(searchText: searchBar.text)
    }
}
// MARK: UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as! UserTableViewCell
        let user = filteredUsers[indexPath.row]
 
        cell.configure(
            cellModel: user,
            photoModel: user.albumModel[indexPath.section].photoModel)
        
        return cell
    }
}
// MARK: UITableViewDelegate
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let presentAlbums = UIContextualAction(style: .normal, title: albums, handler: { [weak self] action, view, completion in
            let albumViewController = AlbumViewController()
            let albumModelForUser = self?.filteredUsers[indexPath.row].albumModel
            albumViewController.albumModelForUser = albumModelForUser!
            let photoModelForUser = self?.filteredUsers[indexPath.section].albumModel[indexPath.row].photoModel
            albumViewController.photoModelForUser = photoModelForUser!
            
            self?.navigationController?.pushViewController(albumViewController, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        })
        presentAlbums.backgroundColor = .gray
        
        let presentPosts = UIContextualAction(style: .normal, title: posts, handler: { [weak self] action, view, completion in
            let postViewController = PostViewController()
            let postModelForUser = self?.filteredUsers[indexPath.row].postModel
            postViewController.postModelForUser = postModelForUser!
            let userModelForPosts = self?.filteredUsers
            postViewController.users = userModelForPosts!
            
            self?.navigationController?.pushViewController(postViewController, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        })
        presentPosts.backgroundColor = .brown
        
        let configuration = UISwipeActionsConfiguration(actions: [presentPosts, presentAlbums])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: delete, handler: { (action,view,completion) in
            
            let userToDelete = self.filteredUsers[indexPath.row]
            
            self.filteredUsers.remove(at: indexPath.row)
            self.users.removeAll(where: {
                $0.id == userToDelete.id
            })
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            completion(true)
            
        })
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
