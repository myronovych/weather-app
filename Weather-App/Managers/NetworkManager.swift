//
//  NetworkManager.swift
//  Weather-App
//
//  Created by rs on 18.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func downloadImage(urlString: String, completed: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: NSString(string: urlString)) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: NSString(string: urlString))
            
            DispatchQueue.main.async {
                completed(image)
            }
        }
        
        task.resume()
    }
}
