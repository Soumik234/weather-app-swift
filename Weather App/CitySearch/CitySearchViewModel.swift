//
//  CitySearchViewModel.swift
//  Weather App
//
//  Created by Nuveda on 25/06/24.
//

import Foundation
import Combine
import SwiftyJSON
import ObjectMapper

class CitySearchViewModel: ObservableObject {
    @Published var searchResults: [AutocompleteResult] = []
    private var cancellables: Set<AnyCancellable> = []
    
    //    var onSearchResultsUpdated: (([AutocompleteResult]) -> Void)?
    
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
                if let autoComplete = Mapper<AutocompleteResult>().mapArray(JSONObject: json.arrayObject){
                    DispatchQueue.main.async {
                        self!.searchResults = Array(autoComplete.prefix(4))
                        print("Parsed results: \(self!.searchResults)")
                    }
                }

            } catch {
                print("Decoding error: \(error)")
            }
        }
    }
    
    
}
