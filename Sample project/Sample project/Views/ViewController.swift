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
    var user: UserDetails!
    var viewModel: UserDetailsViewModel!
//    var userViewController: UserViewController!
    
    
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var userTableView: UITableView!
    
        func add() {
    //        let userViewController = self.storyboard?.instantiateViewController(withIdentifier: "userViewController")
            let userViewController = UserViewController()
            userViewController.userDetailsViewModel = UserDetailsViewModel(userDetails: user)
            present(userViewController, animated: true, completion: nil)
        }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        populateTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        buildViews()
    }
    

    
    
    @objc func cellButtonTapped (_ sender: UIButton) {
        add()
    }
}
