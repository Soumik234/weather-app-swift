//
//  CitySearchViewModel.swift
//  Weather App
//
//  Created by Nuveda on 25/06/24.
//


import Foundation
import Combine
import CoreLocation
import SwiftyJSON
import ObjectMapper

class CitySearchViewModel: ObservableObject {
    @Published var searchResults: [AutocompleteResult] = []
    @Published var currentLocationCity: String?
    @Published var isLoading: Bool = false
    @Published var locationError: String?

    private var cancellables: Set<AnyCancellable> = []
    private let locationManager = LocationManager()

    init() {
           locationManager.$authorizationStatus
               .sink { [weak self] status in
                   print("Authorization status in ViewModel: \(status.rawValue)")
                   switch status {
                   case .authorizedWhenInUse, .authorizedAlways:
                       self?.fetchCityForCurrentLocation()
                   case .denied, .restricted:
                       self?.locationError = "Location access denied. Please enable it in Settings."
                   case .notDetermined:
                       self?.locationManager.requestLocationPermission()
                   @unknown default:
                       break
                   }
               }
               .store(in: &cancellables)
       }

    func fetchCityForCurrentLocation() {
            isLoading = true
        locationManager.startUpdatingLocation()
            
            locationManager.$currentLocation
                .compactMap { $0 }
                .timeout(.seconds(10), scheduler: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure:
                        DispatchQueue.main.async {
                            self?.isLoading = false
                            self?.locationError = "Timed out while fetching location"
                        }
                    }
                } receiveValue: { [weak self] location in
                    self?.reverseGeocode(location: location)
                }
                .store(in: &cancellables)
        }
    func searchCities(query: String) {
        let parameters = [
            "apikey": Constants.apiKey,
            "q": query
        ]
        
        let url = "\(UrlConstants.autocompleteURL)"
        
        NetworkUtility().fetchData(url: url, parameters: parameters) { [weak self] data in
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let json = try JSON(data: data)
                print("Received JSON: \(json)")
                if let autoComplete = Mapper<AutocompleteResult>().mapArray(JSONObject: json.arrayObject) {
                    DispatchQueue.main.async {
                        self?.searchResults = Array(autoComplete.prefix(4))
                        print("Parsed results: \(self?.searchResults)")
                    }
                }
                
            } catch {
                print("Decoding error: \(error)")
            }
        }
    }
    
    private func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            DispatchQueue.main.async {
                if let placemark = placemarks?.first, let cityName = placemark.locality {
                    self?.currentLocationCity = cityName
                    self?.searchCities(query: cityName)
                    print("Current location: \(cityName)")
                } else {
                    self?.locationError = "Couldn't determine your city. \(error?.localizedDescription ?? "")"
                }
                self?.isLoading = false
            }
        }
    }
    
    func requestLocationPermission() {
        locationManager.requestLocationPermission()
    }
}
