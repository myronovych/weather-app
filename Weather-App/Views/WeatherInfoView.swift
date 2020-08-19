//
//  WeatherInfoView.swift
//  Weather-App
//
//  Created by rs on 19.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class WeatherInfoView: UIView {

    var leftInfo = WeatherInfoItem()
    var rightInfo = WeatherInfoItem()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureLeftInfo()
        configureRightInfo()
    }
    
    private func configureLeftInfo() {
        addSubview(leftInfo)
        leftInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftInfo.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftInfo.trailingAnchor.constraint(equalTo: centerXAnchor),
            leftInfo.topAnchor.constraint(equalTo: topAnchor),
            leftInfo.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureRightInfo() {
        addSubview(rightInfo)
        rightInfo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightInfo.leadingAnchor.constraint(equalTo: centerXAnchor),
            rightInfo.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightInfo.topAnchor.constraint(equalTo: topAnchor),
            rightInfo.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setLabels(weather: CityWeather, firstType: WeatherItemType, secondType: WeatherItemType) {
        leftInfo.set(itemType: firstType, value: getValue(weather: weather, forInfoType: firstType))
        rightInfo.set(itemType: secondType, value: getValue(weather: weather, forInfoType: secondType))
    }
    
    func getValue(weather: CityWeather, forInfoType itemType: WeatherItemType) -> String {
        var value = ""
        
        switch itemType {
        case .currTemp:
            value = "\(weather.main.temp) °C"
            
        case .description:
            value = weather.weather[0].description
            
        case .humidity:
            value = "\(weather.main.humidity)%"
            
        case .maxTemp:
            value = "\(weather.main.tempMax) °C"

        case .minTemp:
            value = "\(weather.main.tempMin) °C"
            
        case .pressure:
            value = "\(weather.main.pressure) hPa"
        }
        
        return value
    }
    
}
