//
//  ViewController.swift
//  Names
//
//  Created by Stan on 2018-01-31.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    private let cellID = "tableViewCellID"
    
    private var path: String {
        get {
            let path = Bundle.main.path(forResource: "names", ofType: "plist")
            return path ?? ""
        }
    }
    
    
    /// get a dictionary Array from plist
    private var indexArray: [String] {
        get {
            guard let arr = NSDictionary.init(contentsOfFile: path)?.allKeys as? [String] else { return [String]() }
            return arr.sorted()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
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
    
//    this mothed is not necessary
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

