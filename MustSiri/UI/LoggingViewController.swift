//
//  LoggingViewController.swift
//  MustSiri
//
//  Created by Вадим on 23/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

class LoggingViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.text = Logger.logs()
        self.setupNavigationController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textView.scrollRangeToVisible(NSRange.init(location: self.textView.text.characters.count-1, length: 0))
    }

}
