//
//  WeatherAPIResponse.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import Foundation

class RequestToWeatherAPI{
    
    var weather = weatherModel.self
    var weatherDataAll : weatherModel?
    
    func apiClient(keyword : String,completion: @escaping (weatherModel) -> Void){
    
        let searchURL = "https://weather.tsukumijima.net/api/forecast/city/\(keyword)"
        guard let url = URL(string: searchURL) else { return }
        var request = URLRequest(url: url,timeoutInterval: 4.0)
        request.timeoutInterval = 8.0
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request,completionHandler: { (data,response,error) in

            if let data = data {
              do {
                   let weatherData = try JSONDecoder().decode(weatherModel.self, from: data)
                    
                    let weatherModelData : weatherModel = weatherModel.init(title: weatherData.title, link: weatherData.link, forecasts: weatherData.forecasts)
                
                    self.weatherDataAll = weatherModelData
                
                    completion(self.weatherDataAll!)
                } catch {
                    print(error.localizedDescription)
                    completion(self.weatherDataAll!)
                }
            }
            
        })
        task.resume()
    }
    
    
}
