//
//  CityTableViewCell.swift
//  Weather-App
//
//  Created by rs on 18.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    static let reuseID = "CityCell"
    
    var city: City?
    
    let cityImageView = UIImageView(image: UIImage(systemName: "questionmark.diamond.fill")?.withTintColor(.gray))
    let cityLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(city: City, atRow row: Int) {
        self.city = city
        
        cityLabel.text = city.name
        
        let imageURL = row % 2 == 0 ? ImageUrl.evenImageURL : ImageUrl.oddImageURL
        
        NetworkManager.shared.downloadImage(urlString: imageURL) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.cityImageView.image = image }
        }
    }
    
    private func configureCell() {
        configureImage()
        configureLabel()
    }
    
    private func configureImage() {
        addSubview(cityImageView)
        cityImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 10
        let imageSize: CGFloat = 60
        
        NSLayoutConstraint.activate([
            cityImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            cityImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
 
            cityImageView.widthAnchor.constraint(equalToConstant: imageSize),
            cityImageView.heightAnchor.constraint(equalToConstant: imageSize)
        ])
    }
    
    private func configureLabel() {
        addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cityLabel.font = UIFont.systemFont(ofSize: 40)
                
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: 12),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            cityLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
