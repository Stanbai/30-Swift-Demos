//
//  ViewController.swift
//  SwipeableCell
//
//  Created by Stan on 2018-03-04.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var count = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupUI() {
        self.title = "Swipeable Cell"
        
        tableView = UITableView.init(frame: view.frame)
        view.addSubview(tableView)
        
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
    }
    
    lazy var shareAlert: UIActivityViewController = {
        let activity = UIActivityViewController.init(activityItems: [UIActivityType.postToWeibo,UIActivityType.copyToPasteboard,UIActivityType.postToTwitter,UIActivityType.postToFacebook], applicationActivities: nil)
        return activity
    }()
    
    lazy var downloadAlert: UIAlertController = {
       let alert = UIAlertController.init(title: "Download", message: "Sorry, You cant download now", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }()
}



extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        
        cell.imageView?.image = UIImage.init(named: "\(indexPath.row + 1)")
        cell.textLabel?.text = "This is line" + "\(indexPath.row) ."
        
        return cell
    }

//    API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos)
//    Replace (tableView: editActionsForRowAtIndexPath:)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction.init(style: .destructive, title: "🗑️ \nDelete") { [weak self](action, view, finished) in
            self?.count -= 1
            tableView.deleteRows(at: [indexPath], with: .automatic)
            finished(true)
        }
        deleteAction.backgroundColor = UIColor.gray
        
        let shareAction = UIContextualAction.init(style: .normal, title: "🤗\nShare") { [weak self](action, view, finished) in
            self?.present((self?.shareAlert)!, animated: true, completion: nil)
            finished(true)
        }
        shareAction.backgroundColor = UIColor.orange
        
        let downloadAction = UIContextualAction.init(style: .normal, title: "⬇️\nDownload") { (action, view, finished) in
            self.present(self.downloadAlert, animated: true, completion: nil)
            finished(true)
        }
        downloadAction.backgroundColor = UIColor.blue
        
        return UISwipeActionsConfiguration(actions: [downloadAction,shareAction,deleteAction])
    }
}



