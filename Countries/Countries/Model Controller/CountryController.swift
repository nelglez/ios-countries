//
//  CountryController.swift
//  Countries
//
//  Created by Nelson Gonzalez on 4/9/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class CountryController {
    
    private(set) var countries: [Country] = []
    private let baseUrl = URL(string: "https://restcountries.eu/rest/v2/name")!
    
    
    func fetchCountries(searchTerm: String, completion: @escaping(Error?) -> Void) {
        let url = baseUrl.appendingPathComponent(searchTerm)
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching the countries: \(error)")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let countries = try decoder.decode([Country].self, from: data)
                self.countries = countries
            } catch {
                NSLog("Error decoding: \(error)")
                completion(error)
                return
            }
            
        }.resume()
    }
    
}
