//
//  CityBoxView.swift
//  Weather App
//
//  Created by Nuveda on 04/07/24.
//

import Foundation
import SwiftUI

struct CityBox: View {
    let city: WeatherLocation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(city.city ?? "Unknown City")
                .font(.headline)
                .lineLimit(1)
            Text(city.country?.localizedName ?? "Unknown Country")
                .font(.subheadline)
                .foregroundColor(.secondary)
            if let latitude = city.geoPosition?.latitude,
               let longitude = city.geoPosition?.longitude {
                Text("Lat: \(latitude, specifier: "%.2f"), Lon: \(longitude, specifier: "%.2f")")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(height: 120)
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}
