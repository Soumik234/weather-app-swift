//
//  SplashView.swift
//  Weather App
//
//  Created by Nuveda on 01/07/24.
//

import Foundation
import SwiftUI


struct OnOpenView: View {
    @State private var showSplashScreen = true
    private var isSignedIn = UserDefaults.standard.bool(forKey: "isSignedIn")
    var body: some View {
        Group {
            if showSplashScreen {
                SplashView()
            } else {
                if isSignedIn {
                    WeatherListView()
                }
                else {
                    LoginView()
                }
                
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplashScreen = false
                }
            }
        }
    }
}

struct SplashView: View {
    var body: some View {
        VStack {
            Image(systemName: "cloud.bolt")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
                .padding()
            
            Text("Weather App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
        .edgesIgnoringSafeArea(.all)
    }
}
