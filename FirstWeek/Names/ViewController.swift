//
//  ViewController.swift
//  Names
//
//  Created by Stan on 2017-10-17.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    fileprivate let cellID = "tableViewCellID"
    
    fileprivate var path: String {
        get {
            let path = Bundle.main.path(forResource: "names", ofType: "plist")
            return path ?? ""
        }
    }
    var indexArray: [String] {
        get {
            guard let arr = NSDictionary.init(contentsOfFile: path)?.allKeys as? [String] else { return [String]() }
            
            return arr.sorted()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //    MARK: - Lazy
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: UIScreen.main.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        return tableView
    }()
    
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        guard let arr = NSDictionary.init(contentsOfFile: path)?.value(forKey: indexArray[section]) as? [String] else { return 0 }
        
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        

        guard let arr = NSDictionary.init(contentsOfFile: path)?.value(forKey: indexArray[indexPath.section]) as? [String] else { return cell}
        
        
        cell.textLabel?.text = arr[indexPath.row].description
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexArray
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexArray[section]
    }
}

