//
//  CitiesListVC.swift
//  Weather-App
//
//  Created by rs on 18.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class CitiesListVC: UITableViewController {
    
    var cities = [City]()
    var filteredCities = [City]()
    
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearch()
        fetchCities()
        configureTable()
    }
    
    private func fetchCities() {
        if let url = Bundle.main.url(forResource: "city.list", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                cities = try decoder.decode([City].self, from: data)
            } catch {
                print ("Error occured while fetching cities from json. \(error)")
            }
        }
    }
    
    private func configureSearch() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter city"
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func configureTable() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseID)
        
        tableView.rowHeight = 80
    }
    
    
}

// MARK: - TableView

extension CitiesListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredCities.count : cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseID) as! CityTableViewCell
        
        cell.set(city: isSearching ? filteredCities[indexPath.row] : cities[indexPath.row], atRow: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UISearchResultsUpdating

extension CitiesListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }
        
        isSearching = true
        filteredCities = cities.filter({$0.name.contains(filter)})
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}



