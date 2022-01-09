//
//  ViewController.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {

    private let apiClient = requestToWeatherAPI()
    
    var prefecture : String = "" {
        didSet{
            prefecture = apiClient.title
            tableView.reloadData()
            print("変更されたタイトル：",prefecture)
        }
    }
    
    var weatherInfo : [Forecasts] = [] {
        didSet{
            weatherInfo = apiClient.forecasts
            tableView.reloadData()
            print("変更されたフォーキャスト：",weatherInfo)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")

        
        apiClient.apiClient()
        
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as?  WeatherTableViewCell{
            
            cell.titleLabel.text = prefecture
            cell.dateLabel.text = weatherInfo[indexPath.row].date
            cell.telopLabel.text = weatherInfo[indexPath.row].telop
            
              return cell
          }
          return UITableViewCell()
    }
    
    
}

