//
//  ViewController.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import UIKit

class ViewController: UIViewController {

    private let apiClient = requestToWeatherAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient.apiClient()
    }
}
