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
    
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var userTableView: UITableView!
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        populateTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
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
    
    @objc func cellButtonTapped (_ sender: UIButton) {
        let alert = UIAlertController(title: "Error", message: "Not implemented yet", preferredStyle: .alert)
        let action = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            print("You've pressed cancel");
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
