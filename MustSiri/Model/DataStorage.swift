//
//  DataStorage.swift
//  MustSiri
//
//  Created by Вадим on 20/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

final class DataStorage: NSObject {
    
    private override init() {
        super.init()
        
        let moviesObject = self.jsonFromFile(filename: "movies")
        let moviesObjects = moviesObject["data"] as! [Dictionary<String,Any>]
        
        for i in 0...(moviesObjects.count - 1) {
            let item = moviesObjects[i] 
            let movie = Movie.init(dict: item)
            self.movies.append(movie)
        }
        
        
        let listsObject = self.jsonFromFile(filename: "lists")
        let listsObjects = listsObject["data"] as! [Dictionary<String, Any>]
        
        for i in 0...(listsObjects.count - 1) {
            let item = listsObjects[i]
            let movie = MovieList.init(dict: item)
            self.lists.append(movie)
        }
        
    }
    
    static let shared = DataStorage()
    private(set) var lists : [MovieList] = []
    private(set) var movies : [Movie] = []

    private func jsonFromFile(filename : String) -> Dictionary<String, Any> {
        var object = Dictionary<String, Any>.init()
        do {
            if let file = Bundle.main.url(forResource: filename, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let obj = json as? Dictionary<String, Any> {
                    object = obj
                } else {
                    print("JSON is invalid")
                    Logger.println("Data Storage :: Failed to load JSON. Invalid JSON format.")
                }
            } else {
                Logger.println("Data Storage :: Failed to load JSON. No file found.")
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return object
    }
    
}
