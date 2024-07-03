import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel = SplashViewModel()
    @State private var imageScale: CGFloat = 0.1
    @State private var textOpacity: Double = 0
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "cloud.bolt")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                    .scaleEffect(imageScale)
                    .rotationEffect(.degrees(rotation))
                    .padding()
                
                Text("Weather App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .opacity(textOpacity)
                    .padding()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.5)) {
                imageScale = 1.0
                rotation = 360
            }
            
            withAnimation(.easeIn(duration: 1.0).delay(0.5)) {
                textOpacity = 1.0
            }
            
            viewModel.dismissSplash()
        }
        .fullScreenCover(isPresented: $viewModel.showContent) {
            ContentView()
        }
        .fullScreenCover(isPresented: $viewModel.showLogin) {
            LoginView()
        }
    }
}
