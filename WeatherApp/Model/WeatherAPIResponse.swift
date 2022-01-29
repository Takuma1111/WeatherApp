//
//  WeatherAPIResponse.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import Foundation

class RequestToWeatherAPI{
    
    var weather = weatherModel.self
    var title : String = ""
    var forecasts : [Forecasts] = []
    
    func apiClient(keyword : String,completion: @escaping (String,[Forecasts]) -> Void){
    
        let searchURL = "https://weather.tsukumijima.net/api/forecast/city/\(keyword)"
        guard let url = URL(string: searchURL) else { return }
        var request = URLRequest(url: url,timeoutInterval: 4.0)
        request.timeoutInterval = 8.0
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request,completionHandler: { (data,response,error) in

            self.forecasts = []
            if let data = data {
              do {
                   let weather = try JSONDecoder().decode(weatherModel.self, from: data)
                    self.title = weather.title
                    print("タイトル：",self.title)
                        for value in weather.forecasts{
                            self.forecasts.append(value)
                    }
                
                completion(self.title,self.forecasts)
                } catch {
                    print(error.localizedDescription)
                    completion(self.title,self.forecasts)
                }
            }
            
        })
        task.resume()
    }
    
    
}
