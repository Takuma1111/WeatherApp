//
//  JsonReader.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/19.
//

import Foundation

class SearchIdsJson {
    
    func searchIdsJson(keyword : String) -> String{
        
       /// ①プロジェクト内にある"employees.json"ファイルのパス取得
       guard let url = Bundle.main.url(forResource: "test", withExtension: "json") else {
           fatalError("ファイルが見つからない")
       }
        
       /// ②employees.jsonの内容をData型プロパティに読み込み
       guard let data = try? Data(contentsOf: url) else {
           fatalError("ファイル読み込みエラー")
       }
        
       /// ③JSONデコード処理
       let decoder = JSONDecoder()
       guard let employees = try? decoder.decode([WeatherIdsModel].self, from: data) else {
           fatalError("JSON読み込みエラー")
       }
        
       /// ④データ確認
       for employee in employees {
        print(employee)
        if employee.title == keyword{
            print("検索結果：",employee.id)
            return employee.id
        }
       }
        return "none"
    }
}
