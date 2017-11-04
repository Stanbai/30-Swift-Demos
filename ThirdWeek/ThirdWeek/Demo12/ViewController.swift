//
//  ViewController.swift
//  Demo12
//
//  Created by Stan on 2017-10-29.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let categroyCellReuseIdentifier = "categroyCellReuseIdentifier"
    let contentCollectionCell = "contentCollectionCell"
    
    let SCREENW = UIScreen.main.bounds.size.width
    let SCREENH = UIScreen.main.bounds.size.height
    
    var categroy: [String] = ["龙虾", "蟹类", "贝类"]

    
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "联动"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func setupUI() {
        
//        creat left categroy tableview
        setupCategroy()
        
//        creat right collection view
        setupContentView()
    }

    
//    MARK: - LAZY
    lazy var categroyView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: SCREENW * 0.2, height: SCREENH))
        tableView.rowHeight = 50
        
        return tableView
    }()
    
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        layout.itemSize = CGSize(width: SCREENW * 0.8 * 0.5 - 20, height: SCREENW * 0.7 * 0.75)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: CGRect(x: SCREENW * 0.2, y: 0, width: SCREENW * 0.8, height: SCREENH), collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
}

//MARK: - TableView
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    fileprivate func setupCategroy() {
        categroyView.delegate = self
        categroyView.dataSource = self
        
        categroyView.bounds = view.bounds
        categroyView.center = view.center
        categroyView.register(UITableViewCell.self, forCellReuseIdentifier: categroyCellReuseIdentifier)
        
        self.view.addSubview(categroyView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categroy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categroyCellReuseIdentifier, for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = categroy[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionViewSection = indexPath.row
        let collectionIndexPath = IndexPath(row: 0, section: collectionViewSection)
        contentCollectionView.scrollToItem(at: collectionIndexPath, at: .top, animated: true)
    }

}

//MARK: - CollectionView
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    fileprivate func setupContentView() {
       contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        
        contentCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: contentCollectionCell)
        
        self.view.addSubview(contentCollectionView)
        
    }
    
    fileprivate func nameList(categroyName: String) -> [String] {
        switch categroyName {
        case "龙虾":
            return ["加拿大龙虾","美国龙虾","爱尔兰龙虾","南澳龙","南非油龙"]
        case "蟹类":
            return ["河蟹","石蟹","花蟹","梭子蟹","青蟹","面包蟹","红蟹"]
        case "贝类":
            return ["牡蛎","贻贝","扇贝","蛤"]
        default:
            return ["小乌龟","小王八","你猜"]
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categroy.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameList(categroyName: categroy[section]).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCollectionCell, for: indexPath) as! CollectionViewCell
        cell.name = ""
        cell.name = nameList(categroyName: categroy[indexPath.section])[indexPath.row]
        return cell
    }
    

}



