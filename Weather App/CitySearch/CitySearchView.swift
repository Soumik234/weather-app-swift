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
    @ObservedObject var listVm: WeatherListViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter city name", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .onChange(of: searchText) { newValue in
                        searchViewModel.searchCities(query: newValue)
                    }
                
                List(searchViewModel.searchResults) { result in
                    Button(action: {
                        listVm.addCity(
                            key: result.key ?? "",
                            name: result.localizedName ?? "Unknown City"
                        )
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Text("\(result.localizedName ?? "Unknown City"), \(result.country?.localizedName ?? "Unknown Country")")
                            Spacer()
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Add City", displayMode: .inline)
        }
    }
}
