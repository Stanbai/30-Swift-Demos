//
//  ViewController.swift
//  AnimateTableView
//
//  Created by Stan on 2018-03-04.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

enum ColorType {
    case red
    case green
    case blue
}
class ViewController: UIViewController {
    
    var tableView: UITableView!
    var colorType = ColorType.red
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTableView()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}


extension ViewController {
    fileprivate func animateTableView() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let height = tableView.bounds.size.height
        
        for cell in cells {
            let transformCell = cell as! ColorCell
            transformCell.transform = CGAffineTransform.init(translationX: 0, y: height)
        }
        
        var index = 0.0
        
        for cell in cells {
            let transformCell = cell as! ColorCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * index, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                transformCell.transform = CGAffineTransform.init(translationX: 0, y: 0)
            }, completion: nil)
            
            index += 1
        }
    }
    
    fileprivate func setupUI() {
        tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        tableView.register(ColorCell.self, forCellReuseIdentifier: ColorCell.description())
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.description(), for: indexPath) as! ColorCell
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextVC = ViewController()
        nextVC.colorType = .green

        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(indexPath)
    }
}

extension ViewController {
    fileprivate func colorForIndex(_ indexPath: IndexPath) -> UIColor {
        let color = (CGFloat(indexPath.row) / 10.0) * 0.6
        switch colorType {
        case .red:
            return UIColor.init(red: color, green: 0.0, blue: 0.2, alpha: 0.8)
        case .green:
            return UIColor.init(red: 0.0, green: color, blue: 0.0, alpha: 0.8)
        case .blue:
            return UIColor.init(red: 0.0, green: 0.0, blue: color, alpha: 0.8)
        }
    }
}
