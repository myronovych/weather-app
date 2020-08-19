//
//  WeatherInfoItem.swift
//  Weather-App
//
//  Created by rs on 19.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

enum WeatherItemType {
    case currTemp, description, minTemp, maxTemp, pressure, humidity
}

class WeatherInfoItem: UIView {
    
    var headerLabel = UILabel()
    var infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(itemType: WeatherItemType, value: String) {
        switch itemType {
        case .currTemp:
            headerLabel.text = "CURRENT TEMPERATURE"
            
        case .description:
            headerLabel.text = "DESCRIPTION"
            
        case .humidity:
            headerLabel.text = "HUMIDITY"
            
        case .maxTemp:
            headerLabel.text = "MAX TEMPERATURE"
            
        case .minTemp:
            headerLabel.text = "MIN TEMPERATURE"
            
        case .pressure:
            headerLabel.text = "PRESSURE"
        }
        
        infoLabel.text = value
    }
    
    private func configure() {
        configureHeader()
        configureInfoLabel()
    }
    
    private func configureHeader() {
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        headerLabel.textColor = .lightGray
        headerLabel.font = UIFont.systemFont(ofSize: 13)
        headerLabel.minimumScaleFactor = 0.4
        headerLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
    
    private func configureInfoLabel() {
        addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false

        infoLabel.font = UIFont.systemFont(ofSize: 30)
        infoLabel.minimumScaleFactor = 0.4
        infoLabel.adjustsFontSizeToFitWidth = true
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 5),
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
}
