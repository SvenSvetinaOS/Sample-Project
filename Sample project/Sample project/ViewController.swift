//
//  ViewController.swift
//  Sample project
//
//  Created by Sven Svetina on 25/09/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation
import PureLayout


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jsonService = JsonService()
    
    var dataArray = [UserDetails]()
    
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var userTableView: UITableView!
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        //        getData()
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.isHidden = true
        userTableView.dataSource = self
        userTableView.delegate = self
        
        
        userTableView.register(UINib(nibName: "UserTable", bundle: nil), forCellReuseIdentifier: "userCell")
        // Do any additional setup after loading the view.
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
        
        cell.titleLabel?.text = user.name
        //        cell.titleLabel?.textAlignment = .left
        cell.titleLabel?.autoPinEdge(.left, to: .left, of: cell, withOffset: 8)
        cell.titleLabel?.autoPinEdge(.right, to: .right, of: cell)
        cell.titleLabel?.autoPinEdge(.top, to: .top, of: cell)
        cell.titleLabel?.autoPinEdge(.bottom, to: .bottom, of: cell)
        cell.cellButton?.addTarget(self, action: #selector(ViewController.cellButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func getData() {
        jsonService.fetchData() { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                self.dataArray = data
                let name = data.first!.name
                let address = data.first!.address
                let company = data.first!.company
                print(name, address, company)
            }
        }
    }
    @objc func cellButtonTapped (_ sender: UIButton) {
        let alert = UIAlertController(title: "Error", message: "Not implemented yet", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

