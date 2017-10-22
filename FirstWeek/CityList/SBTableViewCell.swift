//
//  SBTableViewCell.swift
//  CityList
//
//  Created by Stan on 2017-10-21.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit

let HMSCREENW: CGFloat = UIScreen.main.bounds.size.width


protocol SBTableViewCellDelegate {
    func showCountry(indexPath: IndexPath)
}
class SBTableViewCell: UITableViewCell {

    var isOpen: Bool?
    var indexPath: IndexPath?
    var country: CountryModel?
    var delegate: SBTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, country: CountryModel, indexPath: IndexPath) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
 
        self.isOpen = country.isOpen
        self.indexPath = indexPath
        self.country = country
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let countryView = UIView.init(frame: CGRect(x: 0, y: 0, width: HMSCREENW, height: 40))
        countryView.backgroundColor = UIColor.lightGray
        contentView.addSubview(countryView)
        
        let countryNameLabel = UILabel(font: .preferredFont(forTextStyle: .body), textColor: UIColor.darkText, text: country?.countryName)
        countryNameLabel.frame = CGRect(x: 20, y: 0, width: 100, height: 40)
        countryView.addSubview(countryNameLabel)
        
        let btn = UIButton.init(type: .custom)
        let image = UIImage.init(named: (country?.isOpen)! ? "down" : "right")
        btn.setImage(image, for: .normal)
        btn.frame = CGRect(x: HMSCREENW - 40, y: 10, width: 20, height: 20)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        countryView.addSubview(btn)
        
        
        let numberOfCity = country?.cities?.count
        let cityView = UIView.init(frame: CGRect(x: 0, y: 40, width: Int(HMSCREENW), height: numberOfCity! * 40))
        
        for count in 0...(numberOfCity! - 1) {
            let cityNameLabel = UILabel(font: .preferredFont(forTextStyle: .body), textColor: UIColor.darkText, text: country?.cities![count])
            cityNameLabel.frame = CGRect(x: 40, y: count * 40, width: Int(HMSCREENW), height: 40)
            cityView.addSubview(cityNameLabel)
        }
        
        cityView.isHidden = !isOpen!
        contentView.addSubview(cityView)
        
    }
    
    @objc private func btnClick() {
        if delegate != nil {
            delegate?.showCountry(indexPath: self.indexPath!)
        }
    }
}

protocol SBTableViewHeaderDelegate {
    func showContinent(index: Int)
}

class SBTableViewHeader: UIView {
    
    
    var index: Int?
    var delegate: SBTableViewHeaderDelegate?
    
    init(frame: CGRect, contient: ContinentModel, index: Int) {
        super.init(frame: frame)
       self.index = index
        
        backgroundColor = UIColor.darkGray
        
        let contientLabel = UILabel(font: .preferredFont(forTextStyle: .title3), textColor: UIColor.white, text: contient.continentName)
        contientLabel.frame = CGRect(x: 10, y: 0, width: 150, height: 50)
        addSubview(contientLabel)
        
        
        let btn = UIButton.init(type: .custom)
        let image = UIImage.init(named: contient.isOpen ? "remove" : "add")
        btn.setImage(image, for: .normal)
        btn.frame = CGRect(x: HMSCREENW - 50, y: 10, width: 40, height: 40)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        addSubview(btn)
    }
    
    @objc private func btnClick() {
        if delegate != nil {
            delegate?.showContinent(index: self.index!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
