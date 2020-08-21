//
//  CitiesListVC.swift
//  Weather-App
//
//  Created by rs on 18.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit
import RealmSwift

class CitiesListVC: UITableViewController {
    
    var cities: Results<City>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearch()
        fetchAllCities()
        configureTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    private func fetchAllCities() {
        cities = realm.objects(City.self).sorted(byKeyPath: "name", ascending: true)
        if !cities!.isEmpty { return }
        
        if let url = Bundle.main.url(forResource: "city.list", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let fetchedCities = try decoder.decode([City].self, from: data)
                
                try realm.write {
                    realm.add(fetchedCities)
                }
            } catch {
                print ("Error occured while fetching cities from json. \(error)")
            }
        }
    }
    
    private func configureSearch() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter city"
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
    }
    
    private func configureTable() {
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseID)
        
        tableView.rowHeight = 80
    }
}

// MARK: - TableView

extension CitiesListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseID) as! CityTableViewCell
        
        cell.set(city: cities![indexPath.row], atRow: indexPath.row)
        
        return cell
    }
    
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
    
            let destVC = CityWeatherVC()
            guard let cities = cities else { return }
            let city = cities[indexPath.row]
            destVC.title = city.name
    
            destVC.city = city
            destVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(destVC, animated: true)
        }
}

// MARK: - UISearchResultsUpdating

extension CitiesListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            fetchAllCities()
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchAllCities()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        cities = realm.objects(City.self).filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
    }
    
}



