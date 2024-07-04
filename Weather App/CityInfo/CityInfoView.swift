//
//  CityInfoView.swift
//  Weather App
//
//  Created by Nuveda on 03/07/24.
//
import SwiftUI

struct CityInfoView: View {
    @StateObject private var viewModel = CityInfoViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.cities, id: \.city) { city in
                        CityBox(city: city)
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .gridCellUnsizedAxes(.horizontal)
                    }
                }
                .padding()
            }
            .navigationTitle("Top Cities")
            .onAppear {
                if viewModel.cities.isEmpty {
                    viewModel.fetchMoreCities()
                }
            }
            .onChange(of: viewModel.cities) { cities in
                if !cities.isEmpty && !viewModel.isLoading {
                    let thresholdIndex = cities.index(cities.endIndex, offsetBy: -5)
                    if cities.indices.contains(thresholdIndex) {
                        viewModel.fetchMoreCities()
                    }
                }
            }
        }
    }
}
