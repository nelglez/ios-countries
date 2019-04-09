//
//  CountryListTableViewController.swift
//  Countries
//
//  Created by Nelson Gonzalez on 4/9/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import UIKit

class CountryListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let countryController = CountryController()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    
        tableView.tableFooterView = UIView()
    
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

         guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        countryController.fetchCountries(searchTerm: searchTerm) { (error) in
            if let error = error {
                print("Error!: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.searchBar.endEditing(true)
                self.tableView.reloadData()
                self.searchBar.text = nil
            }
        }
        
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countryController.countries.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)

        let countries = countryController.countries[indexPath.row]
        
        cell.textLabel?.text = countries.name
        cell.imageView?.image = UIImage(named: countries.flagName)
       

        return cell
    }
   

   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destinationVC = segue.destination as? CountryDetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC?.countries = countryController.countries[indexPath.row]
        }
    }
   

}
