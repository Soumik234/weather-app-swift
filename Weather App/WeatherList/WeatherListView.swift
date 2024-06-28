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
                WeatherDetailView(viewModel: WeatherDetailViewModel(weather: weather))
            }
            .navigationDestination(isPresented: $isShowingCitySearchView) {
                CitySearchView(autoComplete: viewModel.createEmptyAutocompleteResult())
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
        }
        .onAppear {
            viewModel.weatherDailyForecast()
        }
    }
}



struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}
