//
//  toolbarTheme.swift
//  Weather App
//
//  Created by Nuveda on 01/07/24.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewModel = LoginViewModel()
    var body: some View {
        TabView {
            WeatherListView()
                .tabItem {
                    Image(systemName: "cloud.sun")
                    Text("Weather")
                }
            ProfileView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}