//
//  ViewController.swift
//  Demo23
//
//  Created by Stan on 2017-11-18.
//  Copyright © 2017 Stan Guo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellReuseIdentifier = "CellReuseIdentifier"
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        
        tableView.separatorStyle = .none
        tableView.register(UINib.init(nibName: "DemoCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    lazy var tableView: UITableView = {
       let table = UITableView.init(frame: self.view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self

        return table
    }()

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! DemoCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

