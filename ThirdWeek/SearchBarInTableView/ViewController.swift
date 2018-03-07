//
//  ViewController.swift
//  SearchBarInTableView
//
//  Created by Stan on 2018-03-05.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var searchBar: UISearchBar!
    
    var array = [Pet]()
    var newArray = [Pet]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatas()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    fileprivate func setupDatas() {

        array.append(Pet(name: "Kacy",imageName:"1",category: .cat))
        array.append(Pet(name: "Blacky",imageName:"2",category: .cat))
        array.append(Pet(name: "Bo Bo",imageName:"3",category: .cat))

        array.append(Pet(name: "Kapuk",imageName:"4",category: .dog))
        array.append(Pet(name: "Bonnie",imageName:"5",category: .dog))
        array.append(Pet(name: "Elory",imageName:"6",category: .dog))
        
        newArray = array
    }
    
    fileprivate func setupUI() {
        self.title = "Search Bar in TableView"
        

        
        tableView = UITableView.init(frame: view.frame, style: .plain)
//        tableView.tableHeaderView = UIView()
        
        

        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib.init(nibName: "PetCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: PetCell.description())

        tableView.rowHeight = 100
        
        searchBar = UISearchBar(frame: CGRect.init(x: 0, y:0, width: view.bounds.width, height: 60))
        searchBar.placeholder = "Search Animal by Name"
        
        tableView.tableHeaderView = searchBar

        searchBar.delegate = self
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        newArray = array.filter({ (pet) -> Bool in
            if searchText.isEmpty { return true }
            return pet.name.contains(searchText)
        })
        
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PetCell.description(), for: indexPath) as! PetCell
        
        let model = newArray[indexPath.row]
        cell.nameLabel.text = model.name
        cell.iconImageView.image = UIImage.init(named: model.imageName)
        cell.categoryLabel.text = model.category.rawValue
        
        return cell
    }
}
