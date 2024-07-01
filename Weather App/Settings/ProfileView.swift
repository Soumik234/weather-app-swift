//
//  SettingsView.swift
//  Weather App
//
//  Created by Nuveda on 01/07/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var email: String = "soumikb@example.com"
    @State private var name: String = "Soumik"
    @ObservedObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            // Header Text
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Profile Image
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding()
            
            // Email
            Text(email)
                .font(.headline)
                .padding(.top, 10)
            
            // Name
            Text("Name: \(name)")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.top, 5)
            
            Spacer()
            
            // Logout Button
            Button(action: {
                print("Logout Button tapped!")
                logout()
                
            }) {
                Text("Logout")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
    }
    func logout() {
        UserDefaults.standard.set(false, forKey: "isSignedIn")
        viewModel.isLoggedIn = false
        presentationMode.wrappedValue.dismiss()
    }
}
