//
//  CityInfoVm.swift
//  Weather App
//
//  Created by Nuveda on 03/07/24.
//
import Foundation
import Combine
import SwiftyJSON
import ObjectMapper

class CityInfoViewModel: ObservableObject {
    @Published var cities: [WeatherLocation] = []
    @Published var isLoading = false
    
    private let networkUtility = NetworkUtility()
    private var currentOffset = 0
    private let limit = 20
    
    func fetchMoreCities() {
        guard !isLoading else { return }
        isLoading = true
        
        let parameters = [
            "apikey": Constants.apiKey,
            "offset": "\(currentOffset)",
            "limit": "\(limit)"
        ]
        
        networkUtility.fetchData(url: UrlConstants.topCitiesURL, parameters: parameters) { [weak self] data in
            guard let data = data, let self = self else {
                self?.isLoading = false
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let json = try JSON(data: data)
                    if let newCities = Mapper<WeatherLocation>().mapArray(JSONObject: json.arrayObject) {
                        self.cities.append(contentsOf: newCities)
                        self.currentOffset += newCities.count
                    } else {
                        print("Error mapping top cities")
                    }
                    self.isLoading = false
                } catch {
                    print("Error decoding JSON data: \(error)")
                    self.isLoading = false
                }
            }
        }
    }
}
