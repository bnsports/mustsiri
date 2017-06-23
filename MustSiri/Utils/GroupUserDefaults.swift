//
//  GroupUserDefaults.swift
//  MustSiri
//
//  Created by Вадим on 22/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

class GroupUserDefaults: UserDefaults {
    var titleDisambiguation : Bool {
        set {
            self.set(newValue, forKey: "title_disambiguation")
            self.synchronize()
        }
        
        get {
            if let disambiguation = self.value(forKey: "title_disambiguation") as? Bool {
                return disambiguation
            }
            
            return false
        }
    }
    var listDisambiguation : Bool {
        set {
            self.set(newValue, forKey: "list_disambiguation")
            self.synchronize()
        }
        
        get {
            if let disambiguation = self.value(forKey: "list_disambiguation") as? Bool {
                return disambiguation
            }
            
            return false
        }
    }
    
    init() {
        super.init(suiteName: "group.com.aximedia.mustsiri")!
    }
}
