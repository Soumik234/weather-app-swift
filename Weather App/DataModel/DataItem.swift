//
//  DataItem.swift
//  Weather App
//
//  Created by Nuveda on 03/07/24.
//


import Foundation
import SwiftData

@Model
class Weather: Identifiable, ObservableObject {
    @Attribute(.unique) var id: String
    var cityName: String?
    var headline: Headline?
    var dailyForecasts: [DailyForecast]?

    init(id: String = UUID().uuidString, cityName: String?, headline: Headline?, dailyForecasts: [DailyForecast]?) {
        self.id = id
        self.cityName = cityName
        self.headline = headline
        self.dailyForecasts = dailyForecasts
    }
}

@Model
class Headline: Identifiable {
    var id: String = UUID().uuidString
    var text: String?
    
    init(text: String?) {
        self.text = text
    }
}

@Model
class DailyForecast: Identifiable {
    var id: String = UUID().uuidString
    var temperature: Temperature?
    
    init(temperature: Temperature?) {
        self.temperature = temperature
    }
}

@Model
class Temperature: Identifiable {
    var id: String = UUID().uuidString
    var minimum: TemperatureValue?
    var maximum: TemperatureValue?
    
    init(minimum: TemperatureValue?, maximum: TemperatureValue?) {
        self.minimum = minimum
        self.maximum = maximum
    }
}

@Model
class TemperatureValue: Identifiable {
    var id: String = UUID().uuidString
    var value: Int?
    
    init(value: Int?) {
        self.value = value
    }
}
