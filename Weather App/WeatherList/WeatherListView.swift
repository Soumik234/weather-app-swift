//
//  WeatherListView.swift
//  Weather App
//
//  Created by Nuveda on 24/06/24.
//

import Foundation
import SwiftUI
import ObjectMapper

struct WeatherListView: View {
    @ObservedObject var viewModel = WeatherListViewModel()
    @State private var isShowingCitySearchView = false
    
    var body: some View {
        NavigationStack {
            if viewModel.weatherList.isEmpty {
                VStack {
                    Text("No cities added yet")
                        .font(.title)
                        .foregroundColor(.secondary)
                    
                    Text("Tap the '+' button to add a city")
                        .font(.title)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                    
                    Button(action: {
                        isShowingCitySearchView = true
                    }) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.blue)
                    }
                    .padding(.top, 20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(UIColor.systemBackground))
            }
            List {
                ForEach(viewModel.weatherList) { weather in
                    NavigationLink(value: weather) {
                        WeatherCell(weather: weather)
                    }
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .navigationBarTitle("Weather Forecast")
            .navigationDestination(for: WeatherData.self) { weather in
                if let cityKeyIndex = viewModel.cityNames.firstIndex(of: weather.cityName!) {
                    let cityKey = viewModel.locationKeys[cityKeyIndex]
                    WeatherDetailView(viewModel: WeatherDetailViewModel(weather: weather, cityKey: cityKey))
                }
            }
            
            .navigationDestination(isPresented: $isShowingCitySearchView) {
                CitySearchView(autoComplete: viewModel.createEmptyAutocompleteResult(), listVm: viewModel)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingCitySearchView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .background(Color.blue)
            
        }
    }
}



struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
