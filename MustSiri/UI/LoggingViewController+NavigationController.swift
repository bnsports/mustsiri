//
//  LoggingViewController+NavigationController.swift
//  MustSiri
//
//  Created by Вадим on 23/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

extension LoggingViewController {
    func setupNavigationController() {
        self.navigationItem.title = "Logs"
        
        let logButton = UIBarButtonItem.init(title: "Close", style: .plain, target: self, action: #selector(LoggingViewController.logButtonHandler(sender:)))
        self.navigationItem.rightBarButtonItem = logButton
    }
    
    @objc func logButtonHandler(sender : UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
