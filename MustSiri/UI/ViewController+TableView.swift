//
//  ViewController+TableView.swift
//  MustSiri
//
//  Created by Вадим on 22/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(ViewController.refreshData(sender:)), for: .valueChanged)
    }
    
    @objc func refreshData(sender: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init()
        let defaults = GroupUserDefaults()
        
        if let listTitle = DataStorage.shared.lists[indexPath.section].title {
            if let movies = defaults.object(forKey: listTitle) as? [String] {
                if let movieId = movies[indexPath.row] as? String {
                    if let mov = DataStorage.shared.searchMovies(title: movieId) as? [Movie] {
                        if let movie = mov.first {
                            cell.textLabel?.text = movie.title
                        }
                    }
                }
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataStorage.shared.lists.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let defaults = GroupUserDefaults()
        if let listTitle = DataStorage.shared.lists[section].title {
            if let movies = defaults.object(forKey: listTitle) as? [String] {
                return movies.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DataStorage.shared.lists[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
