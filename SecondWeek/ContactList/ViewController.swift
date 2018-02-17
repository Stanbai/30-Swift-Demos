//
//  ViewController.swift
//  ContactList
//
//  Created by Stan on 2017-10-29.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellReuseIdentifier = ViewController.self.description()
    
    var contactGroup = [GroupModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        set navigationController's title color
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white]
//        set navigationController backItem color
        self.navigationController?.navigationBar.tintColor = UIColor.white
//        set navigationController bar tintColor
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 0.0 / 255, green: 133.0 / 255, blue: 255.0 / 255, alpha: 1.0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initDate()
        setupUI()
    }
    
}

extension ViewController {
    fileprivate func getPersonalModel(_ infoArray:[[String : Any]]) -> [PersonalModel]{
        var modelArray = [PersonalModel]()
        for data in infoArray {
            let model = PersonalModel()
            model.avatar = data["avatar"] as! String
            model.Name = data["Name"] as! String
            model.Mobile = data["Mobile"] as! String
            model.Email = data["Email"] as! String
            model.Notes = data["Notes"] as! String
            
            modelArray.append(model)
        }
        return modelArray
    }
    
    fileprivate func initDate() {
        if let path = Bundle.main.path(forResource: "address", ofType: "plist"), let dataArray = NSArray(contentsOfFile: path) as? [[String: Any]] {
            for data in dataArray {
                let tempGroupModel = GroupModel()
                tempGroupModel.title = data["title"] as! String
                tempGroupModel.info = data["info"] as! [[String : Any]]
                contactGroup.append(tempGroupModel)
            }
        }
    }
    
    fileprivate func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.rowHeight = 60
    }
}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactGroup.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactGroup[section].title
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactGroup[section].info.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let model = getPersonalModel(contactGroup[indexPath.section].info)[indexPath.row]
        cell.textLabel?.text = model.Name
        
        cell.imageView?.image = UIImage.init(named: model.avatar + ".jpg")
        cell.imageView?.layer.cornerRadius = tableView.rowHeight * 0.5
        cell.imageView?.layer.masksToBounds = true
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = getPersonalModel(contactGroup[indexPath.section].info)[indexPath.row]
        
        let vc = DetailVC()
        vc.data = model
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

