//
//  ViewController.swift
//  Sample project
//
//  Created by Sven Svetina on 10/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation
import PureLayout


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jsonService = JsonService()
    var dataArray = [UserDetails]()
    var photos = [Photos]()
    var images: Photos!
    var user: UserDetails!
    var viewModel: UserDetailsViewModel!
    
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var userTableView: UITableView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTable
        let user = self.dataArray[indexPath.row]
        viewModel = UserDetailsViewModel(userDetails: user)
        
        cell.titleLabel?.text = viewModel.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = userTableView.indexPathForSelectedRow
        let currentCell = userTableView.cellForRow(at: indexPath!) as! UserTable
        let userViewController = UserViewController()
        
        userTableView.deselectRow(at: indexPath!, animated: true)
        present(userViewController, animated: true, completion: nil)
        userViewController.nameLabel.text = currentCell.titleLabel.text
        userViewController.phoneLabel?.text = viewModel.phone
        let photoURL = URL(string: photos.first?.url ?? "")
        let photoData = try? Data(contentsOf: photoURL!)
        let image = UIImage(data: photoData!)
        userViewController.userImage.image = image
    }
    
    func setupTableView() {
        userTableView.isHidden = true
        userTableView.dataSource = self
        userTableView.delegate = self
        userTableView.register(UINib(nibName: "UserTable", bundle: nil), forCellReuseIdentifier: "userCell")
    }
    
    func populateTableView() {
        jsonService.fetchData() { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let data):
                    self.dataArray = data
                }
                self.userTableView.reloadData()
                self.userTableView.isHidden = false
            }
        }
        jsonService.fetchPhotos { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let photoData):
                    self.photos = photoData
                }
                self.userTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        populateTableView()
    }
}
