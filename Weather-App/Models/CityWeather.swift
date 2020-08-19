//
//  CityWeather.swift
//  Weather-App
//
//  Created by rs on 18.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation

struct CityWeather: Decodable {
    let coord: Coordinates
    let weather: [Weather]
    let main: MainWeatherInfo
}
