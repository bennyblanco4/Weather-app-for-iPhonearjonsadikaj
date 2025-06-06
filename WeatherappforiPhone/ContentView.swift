import SwiftUI

struct ContentView: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient based on weather conditions
                LinearGradient(
                    gradient: Gradient(colors: weatherViewModel.backgroundColors),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                if weatherViewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(2)
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            // Current weather section
                            CurrentWeatherView(weather: weatherViewModel.currentWeather)
                                .padding()
                            
                            // Forecast section
                            ForecastView(forecast: weatherViewModel.forecast)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle(weatherViewModel.currentWeather.location)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isSearching = true
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        weatherViewModel.refreshWeather()
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.white)
                    }
                }
            }
            .sheet(isPresented: $isSearching) {
                SearchView(onSearch: { location in
                    weatherViewModel.fetchWeather(for: location)
                    isSearching = false
                })
            }
            .alert(isPresented: $weatherViewModel.hasError) {
                Alert(
                    title: Text("Error"),
                    message: Text(weatherViewModel.errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            weatherViewModel.fetchWeather()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}