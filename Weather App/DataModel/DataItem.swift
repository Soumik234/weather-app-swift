//
//  DataItem.swift
//  Weather App
//
//  Created by Nuveda on 03/07/24.
//


import Foundation
import SwiftData


@Model
class SavedCity: Identifiable {
    let id: String
    let locationKey: String
    let cityName: String
    
    init(id: String = UUID().uuidString, locationKey: String, cityName: String) {
        self.id = id
        self.locationKey = locationKey
        self.cityName = cityName
    }
}
