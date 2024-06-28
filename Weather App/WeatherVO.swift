//
//  WeatherVO.swift
//  Weather App
//
//  Created by Nuveda on 25/06/24.
//

import Foundation
import Combine
import ObjectMapper


struct WeatherData: Identifiable, Mappable, Hashable{
    let id: String = UUID().uuidString
    var headline: Headline?
    var dailyForecasts: [DailyForecast]?
    var cityName: String?
    
    static func == (lhs: WeatherData, rhs: WeatherData) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        headline <- map["Headline"]
        dailyForecasts <- map["DailyForecasts"]
    }
    
    struct Headline: Mappable {
        var text: String = ""
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            text <- map["Text"]
        }
    }
    
    struct DailyForecast: Mappable {
        var temperature: Temperature?
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            temperature <- map["Temperature"]
        }
    }
    
    struct Temperature: Mappable {
        var minimum: Minimum?
        var maximum: Maximum?
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            minimum <- map["Minimum"]
            maximum <- map["Maximum"]
        }
    }
    struct Minimum: Mappable {
        var value: Int?
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            value <- (map["Value"])
        }
    }
    
    struct Maximum: Mappable {
        var value: Int?
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            value <- (map["Value"])
        }
    }
    
    
}



struct HourlyForecast: Identifiable, Mappable {
    let id = UUID()
    var weatherIcon: Int?
    var hasPrecipitation: Bool?
    var temperature: Temperature?
    
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        weatherIcon <- map["WeatherIcon"]
        hasPrecipitation <- map["HasPrecipitation"]
        temperature <- map["Temperature"]
    }
    
    struct Temperature: Mappable {
        var value: Int?
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            value <- map["Value"]
        }
    }
}

struct AutocompleteResult: Identifiable, Mappable {
    var id = UUID()
    var key: String?
    var localizedName: String?
    var country: Country?
    init?(map: Map) {}
    mutating func mapping(map: Map) {
        key <- map["Key"]
        localizedName <- map["LocalizedName"]
        country <- map["Country"]
    }
    
    struct Country: Mappable {
        var localizedName: String?
        
        init?(map: Map){}
        
        mutating func mapping(map: Map) {
            localizedName <- map["LocalizedName"]
        }
    }
}

