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

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private func configureTable() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.reuseID)
        
        tableView.rowHeight = 80
    }
    
    
}

extension CitiesListVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseID) as! CityTableViewCell
        
        let imageName = indexPath.row % 2 == 0 ? "Temp3" : "Temp1"
        cell.cityImageView.image = UIImage(named: imageName)
        
        cell.set(city: cities[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension CitiesListVC: UISearchBarDelegate {
    
}



