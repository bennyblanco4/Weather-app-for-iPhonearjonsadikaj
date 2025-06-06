import Foundation
ASDASDDD
SDASD
SDADA

ASD
struct Weather: Identifiable {
    let id: String
    let location: String
    let temperature: Double
    let feelsLike: Double
    let condition: String
    let humidity: Int
    let windSpeed: Double
    let iconName: String
    
    static let placeholder = Weather(
        id: "placeholder",
        location: "Loading...",
        temperature: 0,
        feelsLike: 0,
        condition: "Unknown",
        humidity: 0,
        windSpeed: 0,
        iconName: "cloud"
    )
}

struct Forecast: Identifiable {
    let id: String
    let day: String
    let high: Double
    let low: Double
    let iconName: String
}
