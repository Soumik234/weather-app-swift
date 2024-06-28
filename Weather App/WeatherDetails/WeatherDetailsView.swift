//
//  WeatherDetailsView.swift
//  Weather App
//
//  Created by Nuveda on 25/06/24.
//

import Foundation
import SwiftUI

struct WeatherDetailView: View {
    @ObservedObject var viewModel: WeatherDetailViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.hourlyForecasts) { hour in
                HourlyCell(hourlyForecast:hour)
            }
            
            
            Spacer()
        }
        .navigationBarTitle("Weather Details", displayMode: .inline)
        .onAppear{
            viewModel.fetchHourlyForecast()
        }
    }
    
}

//struct WeatherDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherDetailView(viewModel: WeatherDetailViewModel(weather: WeatherData())
//    }
//}
