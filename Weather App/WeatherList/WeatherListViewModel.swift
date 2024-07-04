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
    var locationKeys: [String] = []
    var cityNames: [String] = []

    let parameters = [
        "apikey": Constants.apiKey,
        "details": "False",
        "metric": "True"
    ]
    
    func createEmptyAutocompleteResult() -> AutocompleteResult {
        let emptyMap = Map(mappingType: .fromJSON, JSON: [:])
        return AutocompleteResult(map: emptyMap)!
    }
    
    func addCity(key: String, name: String) {
        let cityInfo = CityInfo(key: key, name: name)
        locationKeys.append(cityInfo.key)
        cityNames.append(cityInfo.name)
        weatherDailyForecast(cityInfo)
    }
    
    func deleteItems(at offsets: IndexSet) {
        weatherList.remove(atOffsets: offsets)
    }
    func weatherDailyForecast(_ cityInfo: CityInfo){
        let url = dailyURL + cityInfo.key
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
                            weatherData.cityName = cityInfo.name
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


