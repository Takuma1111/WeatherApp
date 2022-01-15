//
//  ViewController.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {

    
    var prefecture : String = "g"
    var weatherInfo : [Forecasts] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        let apiClient_1 = requestToWeatherAPI()
        apiClient_1.apiClient(completion: { title,forecast  in
            self.prefecture = title
            self.weatherInfo = forecast
            DispatchQueue.main.sync {
                   self.tableView.reloadData()
                   return
               }
        })
        
    }
    
    private func tableReload(){
        self.tableView.reloadData()
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection tsection: Int) -> Int {
        print(weatherInfo.count)
        return weatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! WeatherTableViewCell

  
            cell.titleLabel.text = prefecture
            cell.dateLabel.text = weatherInfo[indexPath.row].date
            cell.telopLabel.text = weatherInfo[indexPath.row].telop

            
            return cell
          
    }
    
    
}

