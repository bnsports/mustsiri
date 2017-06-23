//
//  ViewController.swift
//  MustSiri
//
//  Created by Вадим on 20/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupNavigationController()
    }
    
    
}

