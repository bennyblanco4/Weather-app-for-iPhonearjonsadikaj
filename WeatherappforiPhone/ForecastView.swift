import SwiftUI

struct ForecastView: View {
    let forecast: [Forecast]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("5-Day Forecast")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Divider()
                .background(Color.white.opacity(0.5))
            
            ForEach(forecast) { day in
                HStack {
                    Text(day.day)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 100, alignment: .leading)
                    
                    Spacer()
                    
                    Image(systemName: day.iconName)
                        .symbolRenderingMode(.multicolor)
                        .font(.title2)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text("\(Int(day.high))°")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 50, alignment: .trailing)
                    
                    Text("\(Int(day.low))°")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.7))
                        .frame(width: 50, alignment: .trailing)
                }
                .padding(.vertical, 8)
                
                if forecast.last?.id != day.id {
                    Divider()
                        .background(Color.white.opacity(0.3))
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.2))
        )
    }
}