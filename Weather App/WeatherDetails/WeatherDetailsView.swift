import Foundation
import SwiftUI
import SwiftData

struct WeatherDetailView: View {
    @ObservedObject var viewModel: WeatherDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var modelContext
    @Query var weather: [Weather]
    
    var body: some View {
        VStack {
            ForEach(viewModel.hourlyForecasts) { hour in
                HourlyCell(hourlyForecast: hour)
            }
            
            Spacer()
        }
        .navigationBarTitle("Weather Details", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            viewModel.fetchHourlyForecast()
        }
    }
}
