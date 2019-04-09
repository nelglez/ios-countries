//
//  Country.swift
//  Countries
//
//  Created by Nelson Gonzalez on 4/9/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String
    let region: String
    let capital: String
    let population: Int
    let currencies: [String]
    let languages: [String]
    let flagName: String
    
    //What we care about
    enum CountryCodingKeys: String, CodingKey {
        case name
        case region
        case capital
        case population
        case currencies
        case languages
        case alpha3code
        
        enum CurrenciesCodingKeys: String, CodingKey {
            case name
        }
        
        enum LanguagesCodingKeys: String, CodingKey {
            case name
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CountryCodingKeys.self)
        
        let name = try container.decode(String.self, forKey: .name)
        let region = try container.decode(String.self, forKey: .region)
        let capital = try container.decode(String.self, forKey: .capital)
        let population = try container.decode(Int.self, forKey: .population)
        
        var currenciesContainer = try container.nestedUnkeyedContainer(forKey: .currencies)
        var currenciesArray = [String]()
        
        while !currenciesContainer.isAtEnd {
            let nestedContainer = try currenciesContainer.nestedContainer(keyedBy: CountryCodingKeys.CurrenciesCodingKeys.self)
            let nameOfCurrency = try nestedContainer.decode(String.self, forKey: .name)
            currenciesArray.append(nameOfCurrency)
        }
        
        var languagesContainer = try container.nestedUnkeyedContainer(forKey: .languages)
        
        var languageArray = [String]()
        
        while !languagesContainer.isAtEnd {
            let nestedContainer = try languagesContainer.nestedContainer(keyedBy: CountryCodingKeys.LanguagesCodingKeys.self)
            let languageName = try nestedContainer.decode(String.self, forKey: .name)
            languageArray.append(languageName)
        }
        
        
        let alpha3Code = try container.decode(String.self, forKey: .alpha3code)
        
        self.name = name
        self.region = region
        self.capital = capital
        self.population = population
        self.currencies = currenciesArray
        self.languages = languageArray
        self.flagName = alpha3Code.lowercased()
    }
}



