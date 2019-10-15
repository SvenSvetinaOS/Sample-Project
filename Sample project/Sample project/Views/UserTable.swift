//
//  UserTable.swift
//  Sample project
//
//  Created by Sven Svetina on 10/10/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import PureLayout

class UserTable: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userCell") as! UserTable
        let user = self.dataArray[indexPath.row]
        self.user = user
//        userViewController.userDetailsViewModel = UserDetailsViewModel(userDetails: user)
        viewModel = UserDetailsViewModel(userDetails: user)
        
        
        cell.titleLabel?.text = viewModel.name
        
//        cell.titleLabel?.text = user.name
        cell.titleLabel?.autoPinEdge(.left, to: .left, of: cell, withOffset: 8)
        cell.titleLabel?.autoPinEdge(.right, to: .right, of: cell)
        cell.titleLabel?.autoPinEdge(.top, to: .top, of: cell)
        cell.titleLabel?.autoPinEdge(.bottom, to: .bottom, of: cell)
        cell.cellButton?.addTarget(self, action: #selector(cellButtonTapped), for: .touchUpInside)
        
        return cell
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
    }
}
