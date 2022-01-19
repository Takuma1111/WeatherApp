//
//  WeatherAPIResponse.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import Foundation

class requestToWeatherAPI{
    
    var weather = weatherModel.self
    var title : String = ""
    var forecasts : [Forecasts] = []
    
    func apiClient(keyword : String,completion: @escaping (String,[Forecasts]) -> Void){
    
        let searchURL = "https://weather.tsukumijima.net/api/forecast/city/\(keyword)"
        guard let url = URL(string: searchURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request,completionHandler: { (data,response,error) in
            if let data = data {
              do {
                   let weather = try JSONDecoder().decode(weatherModel.self, from: data)
                    self.title = weather.title
                        for value in weather.forecasts{
                            self.forecasts.append(value)
                        }
                
                completion(self.title,self.forecasts)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
        })
        task.resume()
    }
    
    
}
