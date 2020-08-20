//
//  WeatherInfoTableViewCell.swift
//  Weather-App
//
//  Created by rs on 20.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class WeatherInfoTableViewCell: UITableViewCell {
    static let reuseID = "WeatherCell"
    
    var weatherInfo: WeatherInfoView! {
        didSet {
            configure()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(weatherInfo)
        weatherInfo.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            weatherInfo.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            weatherInfo.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            weatherInfo.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            weatherInfo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}
