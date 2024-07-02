//
//  LoginViewModel.swift
//  Weather App
//
//  Created by Nuveda on 24/06/24.
//

import Foundation


class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var isError: Bool = false
    @Published var errorMessage: String = ""
    
    func login() {
        isError = false
        errorMessage = ""
        
        if username.isEmpty && password.isEmpty {
            isError = true
            errorMessage = "Username and password cannot be empty"
        } else if username.isEmpty {
            isError = true
            errorMessage = "Username cannot be empty"
        } else if password.isEmpty {
            isError = true
            errorMessage = "Password cannot be empty"
        } else if username == "Soumik" && password == "soumik" {
            isLoggedIn = true
            UserDefaults.standard.set(true, forKey: "isSignedIn")
            UserDefaults.standard.synchronize()
        } else {
            isError = true
            errorMessage = "Invalid username or password"
        }
    }
}
