//
//  City.swift
//  Weather-App
//
//  Created by rs on 18.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object, Decodable {
    @objc dynamic var name: String?
    @objc dynamic var coord: Coord?
}
