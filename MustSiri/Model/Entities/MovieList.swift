//
//  List.swift
//  MustSiri
//
//  Created by Вадим on 22/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

class MovieList: NSObject, JSONAble {
    private(set) var id : String?
    private(set) var title : String?
    private(set) var movies : [String] = []
    
    init(dict : Dictionary<String, Any>) {
        self.id = dict["id"] as? String
        self.title = dict["title"] as? String
        
        super.init()
    }
    
    func addMovie(id : String) {
        self.movies.append(id)
    }
}
