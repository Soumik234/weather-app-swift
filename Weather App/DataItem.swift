//
//  DataItem.swift
//  Weather App
//
//  Created by Nuveda on 03/07/24.
//


import SwiftUI
import SwiftData

@Model
class Weather {
    @Attribute(.unique) var id: String
    var cityName: String
    var headlineText: String
    var currentTemperature: Int
    var minTemperature: Int
    var maxTemperature: Int
    var date: Date
    
    // Initializer
    init(id: String = UUID().uuidString, cityName: String, headlineText: String, currentTemperature: Int, minTemperature: Int, maxTemperature: Int, date: Date = Date()) {
        self.id = id
        self.cityName = cityName
        self.headlineText = headlineText
        self.currentTemperature = currentTemperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.date = date
    }
}
