//
//  ViewController.swift
//  CityList
//
//  Created by Stan on 2017-10-21.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let cellID = "tableViewCellID"
    var continents = [ContinentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        setupDataSource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func setupDataSource() {
        let china = CountryModel.init(cities: ["北京","上海","广州","深圳"], countryName: "中国")
        let russia = CountryModel.init(cities: ["莫斯科", "叶卡捷琳堡", "下诺夫哥罗德", "罗斯托夫"], countryName: "俄罗斯")
        
        let canada = CountryModel.init(cities: ["渥太华", "温哥华", "多伦多", "蒙特利尔"], countryName: "加拿大")
        
        let usa = CountryModel.init(cities: ["华盛顿", "纽约", "芝加哥", "西雅图","水牛城"], countryName: "美国")
        
        let stan = CountryModel.init(cities: ["川岛芳子", "芙蓉姐姐", "天香哥哥"], countryName: "土鳖国")
        let star = CountryModel.init(cities: ["大包子", "小包子", "馒头","豆角"], countryName: "吃货")
        
        let asia = ContinentModel.init(countries: [china,russia], continentName: "亚洲")
        let northAmerica = ContinentModel.init(countries: [canada,usa], continentName: "北美洲")
        let haha = ContinentModel.init(countries: [stan,star], continentName: "知识星球萌萌哒")
        
        self.continents = [asia,northAmerica,haha]
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


extension ViewController: UITableViewDataSource,UITableViewDelegate,SBTableViewCellDelegate,SBTableViewHeaderDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return continents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return continents[section].isOpen ? (continents[section].countries?.count)! : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let country = continents[indexPath.section].countries?[indexPath.row] else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
            return cell
        }
        
        let cell = SBTableViewCell.init(style: .default, reuseIdentifier: cellID, country: country, indexPath: indexPath)
        cell.delegate = self
            return cell
        }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: HMSCREENW, height: 50)
        
        let sectionHeader = SBTableViewHeader.init(frame: frame, contient: continents[section], index: section)
        sectionHeader.delegate = self
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let country = continents[indexPath.section].countries![indexPath.row]
        return CGFloat(country.isOpen ? 40 + (country.cities?.count)! * 40 : 40)
    }
    
    func showContinent(index: Int) {
        debugPrint("原始状态：\(continents[index].isOpen)")
        continents[index].isOpen = !continents[index].isOpen
        debugPrint("变更后状态:\(continents[index].isOpen)")
        tableView.reloadSections(IndexSet.init(integer: index), with:.automatic)
    }
    
    
    func showCountry(indexPath: IndexPath) {
        continents[indexPath.section].countries![indexPath.row].isOpen = !continents[indexPath.section].countries![indexPath.row].isOpen
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
}

