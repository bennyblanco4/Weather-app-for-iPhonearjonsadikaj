import SwiftUI
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather = Weather.placeholder
    @Published var forecast = [Forecast]()
    @Published var isLoading = true
    @Published var hasError = false
    @Published var errorMessage = ""
    
    private let locationManager = CLLocationManager()
    private let weatherService = WeatherService()
    
    var backgroundColors: [Color] {
        switch currentWeather.condition.lowercased() {
        case _ where currentWeather.condition.contains("clear"):
            return [.blue, .cyan]
        case _ where currentWeather.condition.contains("cloud"):
            return [.gray, Color(red: 0.6, green: 0.6, blue: 0.6)]
        case _ where currentWeather.condition.contains("rain"):
            return [Color(red: 0.4, green: 0.4, blue: 0.6), Color(red: 0.2, green: 0.2, blue: 0.4)]
        case _ where currentWeather.condition.contains("snow"):
            return [Color(red: 0.9, green: 0.9, blue: 1.0), Color(red: 0.7, green: 0.7, blue: 0.9)]
        default:
            return [.blue, Color(red: 0.5, green: 0.7, blue: 1.0)]
        }
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func fetchWeather() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    func fetchWeather(for city: String) {
        isLoading = true
        
        // Simulate API call with a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            // This is mock data - in a real app, you'd call your weather API here
            self.currentWeather = self.getMockWeatherData(for: city)
            self.forecast = self.getMockForecastData()
            self.isLoading = false
        }
    }
    
    func refreshWeather() {
        fetchWeather()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        // In a real app, you would use these coordinates to fetch weather data from an API
        print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        // For demo purposes, we'll use mock data
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.currentWeather = self.getMockWeatherData()
            self.forecast = self.getMockForecastData()
            self.isLoading = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        isLoading = false
        hasError = true
        errorMessage = "Failed to get your location. Please try again or search for a city."
    }
    
    // MARK: - Mock Data
    
    private func getMockWeatherData(for city: String = "New York") -> Weather {
        return Weather(
            id: UUID().uuidString,
            location: city,
            temperature: Double.random(in: 50...85),
            feelsLike: Double.random(in: 45...90),
            condition: ["Clear", "Partly Cloudy", "Cloudy", "Light Rain", "Thunderstorm"].randomElement()!,
            humidity: Int.random(in: 30...90),
            windSpeed: Double.random(in: 0...20),
            iconName: ["sun.max", "cloud.sun", "cloud", "cloud.rain", "cloud.bolt.rain"].randomElement()!
        )
    }
    
    private func getMockForecastData() -> [Forecast] {
        let days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        let icons = ["sun.max", "cloud.sun", "cloud", "cloud.rain", "cloud.bolt.rain"]
        
        return (0..<5).map { i in
            Forecast(
                id: UUID().uuidString,
                day: days[i],
                high: Double.random(in: 60...90),
                low: Double.random(in: 40...65),
                iconName: icons[Int.random(in: 0..<icons.count)]
            )
        }
    }
}