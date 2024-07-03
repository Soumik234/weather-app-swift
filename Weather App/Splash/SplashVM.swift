import Foundation
import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var isShowingSplash = true
    @Published var showLogin = false
    @Published var showContent = false
    
    var isSignedIn: Bool {
        UserDefaults.standard.bool(forKey: "isSignedIn")
    }
    
    func dismissSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.isShowingSplash = false
                if self.isSignedIn {
                    self.showContent = true
                } else {
                    self.showLogin = true
                }
            }
        }
    }
}
