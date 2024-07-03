import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
  @Published var email: String = "soumikb@example.com"
  @Published var name: String = "Soumik Bhattacharyya"
  @Published var selectedTheme: String = "System"
  let themes = ["System", "Light", "Dark"]
  @Published var showLogoutConfirmation = false
  @Published var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isSignedIn")

  func logout() {
    UserDefaults.standard.set(false, forKey: "isSignedIn")
    UserDefaults.standard.synchronize()
    isLoggedIn = false
  }

  func setAppTheme(theme: String) {
    switch theme {
    case "Light":
      UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
    case "Dark":
      UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
    default:
      UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
    }
  }
}
