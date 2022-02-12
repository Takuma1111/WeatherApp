//
//  JsonReader.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/19.
//

import Foundation

class SearchIdsJson {
    
    func searchIdsJson(keyword : String) -> String{
        
       guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else {
           fatalError("ファイルが見つからない")
       }
        
       guard let data = try? Data(contentsOf: url) else {
           fatalError("ファイル読み込みエラー")
       }
        
       let decoder = JSONDecoder()
       guard let jsons = try? decoder.decode([WeatherIdsModel].self, from: data) else {
           fatalError("JSON読み込みエラー")
       }
        
       for json in jsons {

        if json.title == keyword{
            print("検索結果：",json.id)
            return json.id
        }
       }
        return "none"   
    }
}
