//
//  Movie.swift
//  MustSiri
//
//  Created by Вадим on 20/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

class Movie: NSObject, JSONAble {
    private(set) var title : String?
    private(set) var year : String?
    private(set) var poster : String?
    private(set) var id : String?
    
    init(dict : Dictionary<String, Any>) {
        self.title = dict["title"] as? String
        self.year = dict["year"] as? String
        //        self.poster = dict["poster"] as? String
        self.poster = "https://s-media-cache-ak0.pinimg.com/736x/06/cb/33/06cb338efcf3ac37a90caad05fd356a2.jpg"
        self.id = dict["id"] as? String
        
        super.init()
    }
}
