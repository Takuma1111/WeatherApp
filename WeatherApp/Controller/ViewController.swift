//
//  ViewController.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate {

    
    private var prefecture : String = ""
    private var weatherInfo : [Forecasts] = []
    
    private let jsonReader = SearchIdsJson()
    private let reqToWeatherAPI = requestToWeatherAPI()
    private var indicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DelegateとDataSource先を設定
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self

        //indicatorをセットアップ
        setUpIndicator()
        
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil),forCellReuseIdentifier: "customCell")
        
      
    }
    
    private func setUpIndicator(){
        indicator.center = view.center
        indicator.style = .large
        indicator.color = .lightGray
        view.addSubview(indicator)
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

extension ViewController : UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        indicator.startAnimating()
        guard let searchText = searchBar.text else {
            indicator.stopAnimating()
            return
        }
        if let searchKeyWord = searchBar.text{
            if searchKeyWord != "" {
                self.weatherInfo = []
                let ids = jsonReader.searchIdsJson(keyword: searchText)
                if ids != "none"{
                    reqToWeatherAPI.apiClient(keyword: ids
                                              ,completion: { title,forecast  in
                        self.prefecture = title
                        self.weatherInfo = forecast
                        DispatchQueue.main.sync {
                               self.tableView.reloadData()
                                self.indicator.stopAnimating()
                               return
                           }
                    })
                }else{
                    indicator.stopAnimating()
                }
              
            }else{
                indicator.stopAnimating()
            }
        }
    }

}

