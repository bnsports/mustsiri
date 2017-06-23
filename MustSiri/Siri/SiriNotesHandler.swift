//
//  SiriManager.swift
//  MustSiri
//
//  Created by Вадим on 21/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

class SiriNotesHandler : NSObject {    
    func addMovie(movie : String, to list : String, with completion: @escaping (Bool, Error?, Dictionary<String, Any>?) -> Void) {
        sleep(2)
        let success = DataStorage.shared.add(movie: movie, to: list).0
        completion(success, nil, nil)
    }
    
    func searchMovie(title: String, with completion: @escaping ([String]) -> Void) {
        sleep(2)
        completion(DataStorage.shared.searchMovieTitles(title: title))
    }
    
    func searchList(title: String, with completion: @escaping ([String]) -> Void) {
        sleep(2)
        completion(DataStorage.shared.searchListTitles(title: title))
    }
}
