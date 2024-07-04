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
    var key: String?
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


struct WeatherLocation: Mappable,Equatable, Identifiable {
    let id: String = UUID().uuidString
    static func == (lhs: WeatherLocation, rhs: WeatherLocation) -> Bool {
        return lhs.id == rhs.id
    }
    
    var city: String?
    var country: Country?
    var timezone: TimeZone?
    var geoPosition: GeoPosition?
     init?(map: Map) {}

    mutating func mapping(map: Map) {
        city <- map["EnglishName"]
        country <- map["Country"]
        timezone <- map["TimeZone"]
        geoPosition <- map["GeoPosition"]
    }
    
    struct Country: Mappable{
        var localizedName: String?
        init?(map: Map) {}
        mutating func mapping(map: Map) {
           localizedName <- map["EnglishName"]
        }
    }
    
    struct TimeZone: Mappable {
        var code: String?
        var name: String?
        
        init?(map: Map){}
        
        mutating func mapping(map:Map){
          code <- map["Code"]
            name <- map["Name"]
        }
    }
    struct GeoPosition: Mappable {
        var latitude: Double?
        var longitude: Double?
        var elevation: Elevation?
        
        init?(map: Map){}
        
        mutating func mapping(map:Map){
            latitude <- map["Latitude"]
            longitude <- map["Longitude"]
            elevation <- map["Elevation"]
        }
    }
    struct Elevation: Mappable {
        var metric: Metric?
        
        init?(map: Map){}
        
        mutating func mapping(map:Map){
            metric <- map ["Metric"]
        }
        
    }
    
    struct Metric: Mappable {
        var value: Int?
        var unit: String?
        init?(map: Map){}
        mutating func mapping(map:Map){
            value <- map ["Value"]
            unit <- map ["Unit"]
        }
    }
}
struct CityInfo {
    let key: String
    let name: String
}
