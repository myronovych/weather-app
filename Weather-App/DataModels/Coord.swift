//
//  Coord.swift
//  Weather-App
//
//  Created by rs on 21.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation
import RealmSwift

class Coord: Object, Decodable {
    @objc dynamic var lon: Double = 0
    @objc dynamic var lat: Double = 0
}
