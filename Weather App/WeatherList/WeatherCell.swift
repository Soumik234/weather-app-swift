//
//  WeatherCell.swift
//  Weather App
//
//  Created by Nuveda on 24/06/24.
//

import SwiftUI

struct WeatherCell: View {
    let weather: WeatherData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(weather.cityName ?? "Unknown City")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .center)
                
            Text(weather.headline?.text ?? "No headline available")
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 20) {
                temperatureView(label: "Current", value: calculateAverageTemperature(), color: .blue)
                Spacer()
                temperatureView(label: "Min", value: weather.dailyForecasts?.first?.temperature?.minimum?.value, color: .blue)
                Spacer()
                temperatureView(label: "Max", value: weather.dailyForecasts?.first?.temperature?.maximum?.value, color: .red)
            }
        }
        .padding()
        .frame(width: 300, height: 200)
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5, x: 0, y: 0)
    }
    
    private func temperatureView(label: String, value: Int?, color: Color) -> some View {
        VStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("\(value ?? 0)°C")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(color)
        }
    }
    
    private func calculateAverageTemperature() -> Int {
        guard let minTemp = weather.dailyForecasts?.first?.temperature?.minimum?.value,
              let maxTemp = weather.dailyForecasts?.first?.temperature?.maximum?.value else {
            return 0
        }
        return (minTemp + maxTemp) / 2
    }
}
