import SwiftUI

struct CurrentWeatherView: View {
    let weather: Weather
    
    var body: some View {
        VStack(spacing: 16) {
            Text(weather.location)
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(.white)
            
            HStack(spacing: 20) {
                // Weather icon
                Image(systemName: weather.iconName)
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 80))
                    .foregroundStyle(.white)
                
                VStack(alignment: .leading) {
                    // Temperature
                    Text("\(Int(weather.temperature))°")
                        .font(.system(size: 70))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    // Weather condition
                    Text(weather.condition)
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            HStack(spacing: 30) {
                WeatherDataView(value: "\(weather.humidity)%", title: "Humidity", icon: "humidity")
                WeatherDataView(value: "\(weather.windSpeed) mph", title: "Wind", icon: "wind")
                WeatherDataView(value: "\(Int(weather.feelsLike))°", title: "Feels Like", icon: "thermometer")
            }
            .padding(.top, 10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.2))
        )
    }
}

struct WeatherDataView: View {
    let value: String
    let title: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)
            
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
    }
}