//
//  DataStorage+Search.swift
//  MustSiri
//
//  Created by Вадим on 22/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import Foundation

extension DataStorage {
    func searchMovie(id : String) -> Movie? {
        let filtered = self.movies.filter { (movie) -> Bool in
            if let movieId = movie.id {
                return movieId == id
            }
            
            return false
        }
        
        if let mov = filtered.first {
            return mov
        }
        
        return nil
    }
    
    func searchMovies(title : String) -> [Movie] {
        Logger.println("Data storage :: Search for movie :", title, ". Movies from server : ", self.movies.map({$0.title!}))
        
        let filtered = self.movies.filter { (movie) -> Bool in
            if let movieTitle = movie.title {
                return movieTitle.lowercased().contains(title.lowercased())
            }
            
            return false
        }
        
        return filtered
    }
    
    func searchLists(title : String) -> [MovieList] {
        Logger.println("Data storage :: Search for list :", title, ". Lists from server : ", self.lists.map({$0.title!}))
        
        let filtered = self.lists.filter { (list) -> Bool in
            if let listTitle = list.title {
                return listTitle.lowercased().contains(title.lowercased())
            }
            
            return false
        }
        
        return filtered
    }
    
    
    
    func searchMovieTitles(title : String) -> [String] {        
        return self.searchMovies(title: title).map({$0.title!})
    }
    
    func searchListTitles(title : String) -> [String] {
        return self.searchLists(title: title).map({$0.title!})
    }
}
