//
//  WeatherAPIResponse.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import Foundation

class requestToWeatherAPI{
    func apiClient(){
        guard let url = URL(string: "https://weather.tsukumijima.net/api/forecast/city/140010") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request,completionHandler: { (data,response,error) in
            if let data = data {
                print("受け取ったJSON",data)
              do {
                let weather = try JSONDecoder().decode(weatherModel.self, from: data)
                print(weather)
                } catch  {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}
