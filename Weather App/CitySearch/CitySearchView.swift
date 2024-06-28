//
//  CitySearchView.swift
//  Weather App
//
//  Created by Nuveda on 25/06/24.
//


import SwiftUI
struct CitySearchView: View {
    @ObservedObject private var searchViewModel = CitySearchViewModel()
    @State private var searchText = ""
    let autoComplete: AutocompleteResult

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter city name", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: searchText) { newValue in
                        searchViewModel.searchCities(query: newValue)
                    }

                List(searchViewModel.searchResults) { result in
                  Button(action: {
                      NavigationLink {
                                WeatherListView(locationKey: result.locationKey)
                              } label: {
                                 
                              }
                  }) {
                    Text("\(result.localizedName ?? "Unknown City"), \(result.country?.localizedName ?? "Unknown Country")")
                    Image(systemName: "plus.circle.fill")
                      .foregroundColor(.green)
                  }
                  .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
                  .frame(maxWidth: .infinity, alignment: .leading)
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Add City", displayMode: .inline)
        }
    }
}
//viewModel should be another file
