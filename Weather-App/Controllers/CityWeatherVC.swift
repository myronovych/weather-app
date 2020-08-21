//
//  CityWeatherVC.swift
//  Weather-App
//
//  Created by rs on 18.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit
import MapKit

class CityWeatherVC: UIViewController {
    
    var city: City!
    var cityWeather: CityWeather?
    
    let mapView = MKMapView()
    let tableView = UITableView()
    
    let weatherInfoTop = WeatherInfoView()
    let weatherInfoMiddle = WeatherInfoView()
    let weatherInfoBottom = WeatherInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addParallax()
        
        configureMapView()
        fetchWeather()
    }
    
    private func fetchWeather() {
        self.showSpinner()
        
        guard let coord = city.coord else {
            hideSpinner()
            navigationController?.popViewController(animated: true)
            return
        }
        
        NetworkManager.shared.getWeather(coordinates: coord) {  [weak self] weather in
            guard let self = self else { return }
            
            self.hideSpinner()
            
            guard let weather = weather else { return }
            
            self.cityWeather = weather
            
            DispatchQueue.main.async {
                self.configureWeatherInfos()
                self.configureWeatherTableView()
            }
        }
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let cityPin = MKPointAnnotation()
        
        guard let coord = city.coord else { return }
        let location = CLLocationCoordinate2D(latitude: coord.lat, longitude: coord.lon)
        cityPin.coordinate = location
        cityPin.title = city.name
        mapView.addAnnotation(cityPin)
        
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3))
        mapView.setRegion(region, animated: true)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureWeatherTableView() {
        tableView.register(WeatherInfoTableViewCell.self, forCellReuseIdentifier: WeatherInfoTableViewCell.reuseID)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 80
        tableView.layer.cornerRadius = 20
        tableView.layer.borderWidth = 0.5
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -25),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureWeatherInfos() {
        weatherInfoTop.setLabels(weather: cityWeather!, firstType: .currTemp, secondType: .description)
        weatherInfoMiddle.setLabels(weather: cityWeather!, firstType: .minTemp, secondType: .maxTemp)
        weatherInfoBottom.setLabels(weather: cityWeather!, firstType: .humidity, secondType: .wind)
    }
}

extension CityWeatherVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoTableViewCell.reuseID) as! WeatherInfoTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.weatherInfo = weatherInfoTop
        case 1:
            cell.weatherInfo = weatherInfoMiddle
        default:
            cell.weatherInfo = weatherInfoBottom
        }
        
        return cell
    }
}
