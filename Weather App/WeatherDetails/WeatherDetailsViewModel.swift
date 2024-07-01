import Foundation
import Combine
import SwiftyJSON
import ObjectMapper

class WeatherDetailViewModel: ObservableObject {
    @Published var weather: WeatherData
    @Published var hourlyForecasts: [HourlyForecast] = []
    private var cancellable: AnyCancellable?
    private let networkUtility = NetworkUtility()
    var cityKey: String
    
    init(weather: WeatherData, cityKey: String) {
        self.weather = weather
        self.cityKey = cityKey
    }
    
    func fetchHourlyForecast() {
        let baseURL = UrlConstants.hourlyURL + cityKey
        let parameters = [
            "apikey": Constants.apiKey,
            "details": "true",
            "metric": "true"
        ]
        
        networkUtility.fetchData(url: baseURL, parameters: parameters) { [weak self] data in
            guard let data = data, let self = self else {
                return
            }
            
            DispatchQueue.main.async {
                do {
                    let json = try JSON(data: data)
                    if let hourlyForecasts = Mapper<HourlyForecast>().mapArray(JSONObject: json.arrayObject) {
                        self.hourlyForecasts = Array(hourlyForecasts.prefix(8))
                        
                    } else {
                        print("Error mapping hourly forecasts")
                    }
                } catch {
                    print("Error decoding JSON data: \(error)")
                }
            }
        }
    }
}
