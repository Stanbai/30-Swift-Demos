//
//  DetailVC.swift
//  ContactList
//
//  Created by Stan on 2018-02-16.
//  Copyright © 2018 Stan Guo. All rights reserved.
//

import UIKit

class DetailVC: UITableViewController {
    var data: PersonalModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    
}
extension DetailVC {
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let avatarImageView = UIImageView(frame: CGRect(x: 15, y: 15, width: 80, height: 80))
        
        avatarImageView.image = UIImage.init(named: data.avatar + ".jpg")
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.size.width * 0.5
        avatarImageView.layer.masksToBounds = true
        
        headerView.addSubview(avatarImageView)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard indexPath.row == 3 else { return tableView.rowHeight }
        
        return 250
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.description(), for: indexPath) as! DetailCell
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Name"
            cell.detailLabel.text = data.Name
        case 1:
            cell.titleLabel.text = "Mobile"
            cell.detailLabel.text = data.Mobile.mobileFormat(4)
        case 2:
            cell.titleLabel.text = "Email"
            cell.detailLabel.text = data.Email
        case 3:
            cell.titleLabel.text = "Notes"
            cell.detailLabel.text = data.Notes

            cell.detailLabel.frame = CGRect(x: 15, y: cell.titleLabel.frame.maxY + 10, width:cell.titleLabel.bounds.width, height: 200)
            cell.detailLabel.sizeToFit()

        default:
            break
        }
        
        return cell
    }
    
    
    
}

extension DetailVC {
    fileprivate func setupUI() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.description())
        
        tableView.rowHeight = 80
    }
}

class DetailCell: UITableViewCell {
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let leftMargin: CGFloat = 15
        
        titleLabel = UILabel(frame: CGRect(x: leftMargin, y: 10, width: self.contentView.bounds.width - leftMargin, height: 18))
        titleLabel.textColor = UIColor.blue
        
        detailLabel = UILabel(frame: CGRect(x: leftMargin, y: titleLabel.frame.maxY + 10, width: self.contentView.bounds.width - leftMargin, height: 20))
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .left
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Mobile number Format
extension String {
    mutating func mobileFormat(_ index:Int) -> String {
        var temp = 0
        for i in 1...(self.count / index) {
            self.insert("-", at: self.prefix(i*index+temp).endIndex)
            temp = temp + 1
        }
        if self.last == "-" {
            let end = self.index(self.endIndex, offsetBy: -2)
            let range: Range<String.Index> = end..<self.endIndex
            self.replaceSubrange(range, with: "")
        }
        return self
    }
    
}
