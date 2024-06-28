//
//  ContentView.swift
//  Weather App
//
//  Created by Nuveda on 24/06/24.
//


import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Image("LoginImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("LoginIcon")
                
                VStack {
                    if viewModel.isLoggedIn {
                        Text("You are logged in \(viewModel.username)")
                            .foregroundColor(.black)
                    }
                    if viewModel.isError {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Username", text: $viewModel.username)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $viewModel.password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button(action: {
                        viewModel.login()
                    }) {
                        Text("Login")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color.white.opacity(0.5))
                .cornerRadius(10)
                .padding()
                .frame(width: 400, height: 150)
                .padding(.top,50)
                Spacer()
                    .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
                        WeatherListView()
                    }
            }
        }
        
        .navigationBarTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
