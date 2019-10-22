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


class UserTableViewController: UITableViewController {
    
    var jsonService = JsonService()
    var dataArray = [UserDetails]()
    var photos = [Photos]()
    var user: UserDetails!
    var viewModel: UserDetailsViewModel!
    
    @IBOutlet weak var fetchButton: UIButton!
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userTableCell", for: indexPath)
        let user = self.dataArray[indexPath.row]
        let viewModel = UserDetailsViewModel(userDetails: user, addressInfo: user.address, geoInfo: user.address.geo, companyInfo: user.company)
        
        cell.textLabel?.text = viewModel.name
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = self.dataArray[indexPath.row]
        let viewModel = UserDetailsViewModel(userDetails: user, addressInfo: user.address, geoInfo: user.address.geo, companyInfo: user.company)
        
        let userViewController = UserViewController()
        present(userViewController, animated: true, completion: nil)
        
        userViewController.nameLabel.text = viewModel.name
        userViewController.phoneLabel?.text = viewModel.phone
        
        let photoURL = URL(string: photos.first?.url ?? "")
        let photoData = try? Data(contentsOf: photoURL!)
        let image = UIImage(data: photoData!)
        userViewController.userImage.image = image
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
                self.tableView.reloadData()
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
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "userTableCell")
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        populateTableView()
    }
}
