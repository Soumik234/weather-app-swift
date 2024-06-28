//
//  WeatherListViewModel.swift
//  Weather App
//
//  Created by Nuveda on 24/06/24.
//

import Foundation
import Combine
import SwiftUI
import ObjectMapper
import SwiftyJSON
//swiftyjson


class WeatherListViewModel: ObservableObject{
    @Published var weatherList: [WeatherData] = []
    
    private var cancellable: AnyCancellable?
    private let networkUtility = NetworkUtility()
    
    let dailyURL = UrlConstants.dailyURL
    var locations = [Constants.kolkata, Constants.banglore, Constants.pune, Constants.mumbai]
    var cityNames = [
        Constants.kolkata: "Kolkata",
        Constants.banglore: "Bangalore",
        Constants.pune: "Pune",
        Constants.mumbai: "Mumbai"
    ]
    let parameters = [
        "apikey": Constants.apiKey,
        "details": "False",
        "metric": "True"
    ]
    //    func addCity(locationKey: String) {
    //        if !locations.contains(locationKaey) {
    //            locations.append(locationKey)
    //           weatherDailyForecast()
    //        }
    //        func deleteItems(at offsets: IndexSet){
    //            locations.remove(atOffsets: offsets)
    //            weatherList.remove(atOffsets: offsets)
    //
    //        }
    //    }
     func createEmptyAutocompleteResult() -> AutocompleteResult {
        let emptyMap = Map(mappingType: .fromJSON, JSON: [:])
        return AutocompleteResult(map: emptyMap)!
    }
    
    func deleteItems(at offsets: IndexSet) {
           weatherList.remove(atOffsets: offsets)
       }
    func weatherDailyForecast(){
        for location in locations {
            let url = dailyURL + location
            print(url)
            networkUtility.fetchData(url: url, parameters: parameters) { [weak self] data in
                guard let self = self, let data = data else { return }
                print("Response for \(data)")
                DispatchQueue.main.async {
                    do {
                        let swiftJson = try JSON(data: data)
                        if let weatherDataDictionary = swiftJson.dictionaryObject {
                            let weatherData = Mapper<WeatherData>().map(JSONObject: weatherDataDictionary)
                            if var weatherData = weatherData {
                                weatherData.cityName = self.cityNames[location] ?? "Unknown City"
                                self.weatherList.append(weatherData)
                            } else {
                                print("Error mapping")
                            }
                        } else {
                            print("Error converting SwiftyJSON to Dictionary")
                        }
                    } catch {
                        print("Error decoding JSON data: \(error)")
                    }
                }
            }
        }
    }
    
    
}


