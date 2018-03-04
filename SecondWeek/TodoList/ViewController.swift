//
//  ViewController.swift
//  TodoList
//
//  Created by Stan on 2018-02-18.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tableView: UITableView!
    var datas = [TodolistModel]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initData()
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupTableView()
    }

}

extension ViewController {
    fileprivate func initData() {
        
//        From plist file read data
        guard let plistPath = Bundle.main.path(forResource: "todolist", ofType: "plist") else { return }
        guard let dataArray = NSArray.init(contentsOfFile: plistPath) else { return }

        
        let filePath = NSHomeDirectory() + "/Documents/todolist.plist"
        
        //whether the file exists in sandbox . If it doesnt exist, create it.
        if FileManager.default.fileExists(atPath: filePath) == false {
            dataArray.write(toFile: filePath, atomically: true)
        }
        guard let sourceDatas = NSArray.init(contentsOfFile: filePath) else { return }
        
        for data in sourceDatas {
            datas.append(TodolistModel.init(data as! [String: Any]))
        }
        
    }
    
    fileprivate func setupTableView() {
        tableView = UITableView.init(frame: view.frame, style: .plain)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodolistCell.self, forCellReuseIdentifier: TodolistCell.description())
    }
    
    
    fileprivate func setupNav() {
        let editItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editItemClick))
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItemClick))
        
        self.navigationItem.leftBarButtonItem = editItem
        self.navigationItem.rightBarButtonItem = addItem
    }
    
    
//    edit tableview edit mothed
    @objc fileprivate func editItemClick() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    @objc fileprivate func addItemClick() {
        datas.removeAll()
        self.navigationController?.pushViewController(AddViewController(), animated: true)
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodolistCell.description(), for: indexPath) as! TodolistCell
        
        let model = datas[indexPath.row]
        cell.imageView?.image = UIImage.init(named: model.icon + ".png")
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = model.date.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            datas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let move = datas.remove(at: sourceIndexPath.row)
        datas.insert(move, at: destinationIndexPath.row)
    }
}

class TodolistCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TodolistModel: NSObject {
   @objc var title = ""
   @objc var date = ""
   @objc var icon = ""
    
    init(_ dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
