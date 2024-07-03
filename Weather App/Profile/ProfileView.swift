import SwiftUI
struct ProfileView: View {
    @State private var email: String = "soumikb@example.com"
    @State private var name: String = "Soumik"
    @ObservedObject var viewModel = LoginViewModel()
    @ObservedObject var vm = SplashViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            VStack {
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
                    .padding(.bottom, 15)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Preference:")
                    
                    Picker("Theme", selection: $isDarkMode) {
                        Text("Light").tag(false)
                        Text("Dark").tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: isDarkMode) { value in
                        setAppTheme(isDarkMode: value)
                    }
                }
                
                Spacer()
                
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
            .navigationBarTitle("Profile")
            .padding()
            .background(Color(UIColor.systemBackground))
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .onAppear {
                setAppTheme(isDarkMode: isDarkMode)
            }
        }
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "isSignedIn")
        UserDefaults.standard.synchronize()
        viewModel.isLoggedIn = false
        presentationMode.wrappedValue.dismiss()
    }
    
    func setAppTheme(isDarkMode: Bool) {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
}