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
import SwiftData
//swiftyjson


class WeatherListViewModel: ObservableObject{
    @Published var weatherList: [WeatherData] = []
    @Published var savedCities: [SavedCity] = []
       
       private var cancellable: AnyCancellable?
       private let networkUtility = NetworkUtility()
    private let modelContainer: ModelContainer
    
    let dailyURL = UrlConstants.dailyURL
 

    let parameters = [
        "apikey": Constants.apiKey,
        "details": "False",
        "metric": "True"
    ]
    @MainActor private func loadSavedCities() {
            let descriptor = FetchDescriptor<SavedCity>(sortBy: [SortDescriptor(\.cityName)])
            do {
                savedCities = try modelContainer.mainContext.fetch(descriptor)
                for city in savedCities {
                    weatherDailyForecast(CityInfo(key: city.locationKey, name: city.cityName))
                }
            } catch {
                print("Failed to fetch SavedCities: \(error)")
            }
        }
    init() {
            do {
                modelContainer = try ModelContainer(for: SavedCity.self)
                loadSavedCities()
            } catch {
                fatalError("Failed to create ModelContainer for SavedCity: \(error)")
            }
        }
        
    func createEmptyAutocompleteResult() -> AutocompleteResult {
        let emptyMap = Map(mappingType: .fromJSON, JSON: [:])
        return AutocompleteResult(map: emptyMap)!
    }
  
        
    @MainActor func addCity(key: String, name: String) {
            let newCity = SavedCity(locationKey: key, cityName: name)
            modelContainer.mainContext.insert(newCity)
            savedCities.append(newCity)
            do {
                try modelContainer.mainContext.save()
            } catch {
                print("Failed to save new city: \(error)")
            }
            weatherDailyForecast(CityInfo(key: key, name: name))
        }
        
    @MainActor func deleteItems(at offsets: IndexSet) {
            for index in offsets {
                let cityToDelete = savedCities[index]
                modelContainer.mainContext.delete(cityToDelete)
            }
            savedCities.remove(atOffsets: offsets)
            weatherList.remove(atOffsets: offsets)
            do {
                try modelContainer.mainContext.save()
            } catch {
                print("Failed to save after deleting cities: \(error)")
            }
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


