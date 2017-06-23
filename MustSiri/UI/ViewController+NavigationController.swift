//
//  ViewController+NavigationController.swift
//  MustSiri
//
//  Created by Вадим on 23/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

extension ViewController {
    func setupNavigationController() {
        self.navigationItem.title = "Must"
        
        let logButton = UIBarButtonItem.init(title: "logs", style: .plain, target: self, action: #selector(ViewController.logButtonHandler(sender:)))
        self.navigationItem.rightBarButtonItem = logButton
    }
    
    @objc func logButtonHandler(sender : UIButton) {
        self.performSegue(withIdentifier: "logs", sender: self)
    }
}
