//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Mohammad Arsalan on 11/05/2021.
//

import SwiftUI

private struct Weather: Identifiable {
    var id: Int { temperature }
    
    var day: String
    var imageName: String
    var temperature: Int
}

private let weatherDays: [Weather] = [
    Weather(day: "tue", imageName: "cloud.sun.fill", temperature: 74),
    Weather(day: "wed", imageName: "sun.max.fill", temperature: 88),
    Weather(day: "thu", imageName: "wind.snow", temperature: 55),
    Weather(day: "fri", imageName: "sunset.fill", temperature: 60),
    Weather(day: "sat", imageName: "snow", temperature: 25)
]

struct ContentView: View {
    
    @State private var isNight = false
    let colors: [Color] = [.red, .green, .blue]
    
    
    
    var body: some View {
        ZStack{
            BackgroundView(isNight: $isNight)
            
            VStack{
                CityTextView(cityName: "Karachi, PK")
                
                CurrentWeatherStatusView(imageName: isNight ? "moon.stars.fill" : "cloud.sun.fill",
                                         temperature: 76)
                
                HStack(spacing: 25) {
                    
                    ForEach(weatherDays) { weatherDay in
                        WeatherDayView(dayOfWeek: weatherDay.day.uppercased(),
                                       imageName: weatherDay.imageName,
                                       temperature: weatherDay.temperature)
                    }
                }
                
                Spacer()
                
                Button{
                    print("tapped")
                    isNight.toggle()
                    
                } label: {
                    WeatherButton(title: "Change Day Time",
                                  backgroundColor: .white,
                                  textColor: .blue)
                }
                
                Spacer()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .foregroundColor(.white)
                .font(.system(size: 28, weight: .medium))
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing )
            .edgesIgnoringSafeArea(.all)
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct CurrentWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
            
        }
        .padding(.bottom, 40)
    }
}


