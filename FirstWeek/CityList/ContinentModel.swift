//
//  ContinentModel.swift
//  CityList
//
//  Created by Stan on 2017-10-21.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit

class ContinentModel: NSObject {
    var countries: [CountryModel]?
    var continentName: String?
    var isOpen: Bool = true
    
    init(countries: [CountryModel], continentName: String) {
        super.init()
        
        self.countries = countries
        self.continentName = continentName
    }
}




class CountryModel: NSObject {
    var cities: [String]?
    var countryName: String?
    var isOpen: Bool = false
    
    init(cities: [String], countryName: String) {
        super.init()
        
        self.cities = cities
        self.countryName = countryName
    }
}
