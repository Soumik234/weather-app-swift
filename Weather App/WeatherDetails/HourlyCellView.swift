import SwiftUI

struct HourlyCell: View {
    let hourlyForecast: HourlyForecast

    var body: some View {
        HStack(spacing: 16) {
            precipitationText
            Spacer()
            weatherIcon
            Spacer()
            temperatureText
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5))
        .padding(.horizontal)
    }

    private var precipitationText: some View {
        Text("Precipitation: \(hourlyForecast.hasPrecipitation! ? "Yes" : "No")")
            .padding(.vertical, 8)
            .foregroundColor(.blue)
            .font(.headline)
    }

    private var weatherIcon: some View {
        var imgId: String {
            if hourlyForecast.weatherIcon! > 9 {
                return String(hourlyForecast.weatherIcon!)
            } else {
                return "0\(hourlyForecast.weatherIcon!)"
            }
        }

        let iconUrl = "https://developer.accuweather.com/sites/default/files/\(imgId)-s.png"

        return AsyncImage(url: URL(string: iconUrl)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            case .failure:
                Image(systemName: "photo")
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }

    private var temperatureText: some View {
        Text("\(hourlyForecast.temperature?.value ?? 0)°C")
            .foregroundColor(.red)
            .font(.title2)
            .fontWeight(.semibold)
    }
}
