//
//  NewsTableViewController.swift
//  RSSReader
//
//  Created by Stan on 2018-03-04.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit
enum CellState {
    case open
    case close
}

class NewsTableViewController: UITableViewController {
    fileprivate let feedParser = FeedParser()
    fileprivate let feedURL = "https://developer.apple.com/news/rss/news.rss"
    
    fileprivate var rssItems:[(title: String, publishDate: String, description: String)]?
    //    use an array to memory the cell open state. Fix reuse cell state issue.
    fileprivate var cellStates: [CellState]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = rssItems else { return 0 }
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        if let item = self.rssItems?[indexPath.row] {
            cell.titleLabel.text = item.title
            cell.dateLabel.text = item.publishDate
            cell.descriptionLabel.text = item.description
            
            if let state = cellStates?[indexPath.row] {
                cell.descriptionLabel.numberOfLines = state == .close ? 4 : 0
            }
        }
        
        return cell
    }
    
    //    MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as! NewsTableViewCell
        
        //        beginUpdates and endUpdates must be used in pairs
        tableView.beginUpdates()
        cell.descriptionLabel.numberOfLines = cell.descriptionLabel.numberOfLines == 4 ? 0 : 4
        cellStates?[indexPath.row] = cell.descriptionLabel.numberOfLines == 4 ? .close : .open
        tableView.endUpdates()
    }
}


extension NewsTableViewController {
    fileprivate func setupUI() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .singleLine
    }
    
    fileprivate func loadData() {
        feedParser.parseFeed(feedURL: feedURL) {[weak self] (rssItems) in
            self?.rssItems = rssItems
            self?.cellStates = Array.init(repeating: .close, count: rssItems.count)
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
