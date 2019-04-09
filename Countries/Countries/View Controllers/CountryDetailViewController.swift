//
//  CountryDetailViewController.swift
//  Countries
//
//  Created by Nelson Gonzalez on 4/9/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    var countries: Country? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    private func updateViews() {
        guard let countries = countries, isViewLoaded else {return}
        
        countryNameLabel.text = countries.name
        capitalLabel.text = "Capital: \(countries.capital)"
        populationLabel.text = "Population: \(countries.population)"
        flagImageView.image = UIImage(named: countries.flagName)
    }

    

}
