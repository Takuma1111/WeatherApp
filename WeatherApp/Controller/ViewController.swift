//
//  ViewController.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import UIKit
import SwiftSVG


class ViewController: UIViewController,UITableViewDelegate {

    
    private var prefecture : String = ""
    private var weatherInfo : [Forecasts] = []
    
    private let jsonReader = SearchIdsJson()
    private let reqToWeatherAPI = RequestToWeatherAPI()
    private var indicator = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //エラー通知メッセージ
    let noInput = SearchError.noInput
    let noResponse = SearchError.noResponse
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DelegateとDataSource先を設定
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self

        //indicatorをセットアップ
        setUpIndicator()
    
        //cellを登録
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil),forCellReuseIdentifier: "customCell")
        
 
    }
    
    private func setUpIndicator(){
        indicator.center = view.center
        indicator.style = .large
        indicator.color = .lightGray
        view.addSubview(indicator)
    }
    
    private func showSearchAlert(_ message : String) {
           let alert = UIAlertController(title: "⚠️警告⚠️", message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
    }
    
    private func getImageByUrl(url: String) -> UIView{
        let svgURL = URL(string: url)!
        let hammock = UIView(SVGURL: svgURL) { (svgLayer) in
            svgLayer.fillColor = UIColor(red:0.52, green:0.16, blue:0.32, alpha:1.00).cgColor
            svgLayer.resizeToFit(self.view.bounds)
        }
        return hammock
    }
    
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection tsection: Int) -> Int {
        return weatherInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! WeatherTableViewCell

            cell.titleLabel.text = prefecture
            cell.weatherView = getImageByUrl(url: weatherInfo[indexPath.row].image.url)
            cell.dateLabel.text = weatherInfo[indexPath.row].date
            cell.telopLabel.text = weatherInfo[indexPath.row].telop
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.layer.bounds.height / 4)
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
                            if self.prefecture == "" && self.weatherInfo.count == 0{
                                self.showSearchAlert(self.noResponse.errorDescription!)
                            }
                            self.indicator.stopAnimating()
                            print("画像イメージ：",self.weatherInfo[0].image.url)
    
                            return
                        }
                    })
                }else{
                    indicator.stopAnimating()
                    showSearchAlert(noResponse.errorDescription!)
                }
            }else{
                indicator.stopAnimating()
                showSearchAlert(noInput.errorDescription!)
            }
        }
    }

}

