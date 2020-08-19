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
    var weatherInfoStack = UIStackView()
    
    let weatherInfoTop = WeatherInfoView()
    let weatherInfoMiddle = WeatherInfoView()
    let weatherInfoBottom = WeatherInfoView()
    
    let seperator = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        // navigation bar problem
        configureMapView()
        fetchWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    private func fetchWeather() {
        self.showSpinner()
        NetworkManager.shared.getWeather(coordinates: city.coord) {  [weak self] weather in
            guard let self = self else { return }
            
            self.hideSpinner()
            
            guard let weather = weather else { return }
            
            self.cityWeather = weather
            
            DispatchQueue.main.async {
                self.configureWeatherInfos()
                self.configureWeatherInfoStack()                
            }
        }
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let cityPin = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: city.coord.lat, longitude: city.coord.lon)
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
    
    private func configureWeatherInfoStack() {
        view.addSubview(weatherInfoStack)
        weatherInfoStack.distribution = .fillProportionally
        weatherInfoStack.axis = .vertical
        weatherInfoStack.translatesAutoresizingMaskIntoConstraints = false
        
        weatherInfoStack.addArrangedSubview(weatherInfoTop)
        weatherInfoStack.addArrangedSubview(weatherInfoMiddle)
        weatherInfoStack.addArrangedSubview(weatherInfoBottom)
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            weatherInfoStack.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: padding),
            weatherInfoStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            weatherInfoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            weatherInfoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureWeatherInfos() {
        weatherInfoTop.setLabels(weather: cityWeather!, firstType: .currTemp, secondType: .description)
        weatherInfoMiddle.setLabels(weather: cityWeather!, firstType: .minTemp, secondType: .maxTemp)
        weatherInfoBottom.setLabels(weather: cityWeather!, firstType: .humidity, secondType: .pressure)
    }
}
