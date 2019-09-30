//
//  ViewController.swift
//  Sample project
//
//  Created by Sven Svetina on 25/09/2019.
//  Copyright © 2019 Sven Svetina. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    
    var jsonService = JsonService()
    
    var dataArray = [UserDetails]()
    
    @IBOutlet weak var fetchButton: UIButton!
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
                print(name, address)
            }
        }
    }
}

