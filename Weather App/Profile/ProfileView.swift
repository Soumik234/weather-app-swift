import SwiftUI

struct ProfileView: View {
  @ObservedObject var viewModel = ProfileViewModel()
  @Environment(\.presentationMode) var presentationMode

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
        Text(viewModel.email)
          .font(.headline)
          .padding(.top, 10)

        // Name
        Text("Name: \(viewModel.name)")
          .font(.headline)
          .foregroundColor(.gray)
          .padding(.top, 5)
          .padding(.bottom, 15)

        VStack(alignment: .leading, spacing: 10) {
          Text("Preference:")

          Picker("Theme", selection: $viewModel.selectedTheme) {
            ForEach(viewModel.themes, id: \.self) { theme in
              Text(theme).tag(theme)
            }
          }
          .pickerStyle(MenuPickerStyle())
          .padding()
          .onChange(of: viewModel.selectedTheme) { value in
            viewModel.setAppTheme(theme: value)
          }
        }

        Spacer()

        Button(action: {
          viewModel.showLogoutConfirmation = true
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
        .confirmationDialog("Are you sure you want to logout?", isPresented: $viewModel.showLogoutConfirmation) {
          Button("Logout", role: .destructive) {
            viewModel.logout()
            presentationMode.wrappedValue.dismiss()
          }
          Button("Cancel", role: .cancel) {}
        }
      }
      .navigationBarTitle("Profile")
      .padding()
      .background(Color(UIColor.systemBackground))
      .onAppear {
        viewModel.setAppTheme(theme: viewModel.selectedTheme)
      }
    }
  }
}
