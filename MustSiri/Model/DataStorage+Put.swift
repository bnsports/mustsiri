//
//  DataStorage+Put.swift
//  MustSiri
//
//  Created by Вадим on 22/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import Foundation

extension DataStorage {
    func add(movie : String, to list : String) -> (Bool, Error?, Dictionary<String, Any>?) {
        Logger.println("Data storage :: add movie:", movie, "to list:", list)
        let defaults = GroupUserDefaults()
        if var ids = defaults.object(forKey: list) as? [String] {
            if ids.contains(movie) {
                Logger.println("Data storage :: add movie failed because list already contains this movie")
                return (false, nil, nil)
            }
            
            ids.append(movie)
            defaults.setValue(ids, forKey: list)
            defaults.synchronize()
        } else {
            var ids : [String] = []
            ids.append(movie)
            
            defaults.setValue(ids, forKey: list)
            defaults.synchronize()
        }
        
        if let l = self.searchLists(title: list).first {
            if let m = self.searchMovies(title: movie).first {
                l.addMovie(id: m.id!)
            }
        }
        
        return (true, nil, nil)
    }
    
    
}
