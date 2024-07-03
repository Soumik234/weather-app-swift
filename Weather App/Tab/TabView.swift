//
//  toolbarTheme.swift
//  Weather App
//
//  Created by Nuveda on 01/07/24.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewModel = LoginViewModel()
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "AdaptiveColor")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
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
        }.tint(.blue)
            .onAppear {
                setupNavigationBarAppearance()
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
