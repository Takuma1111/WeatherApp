//
//  ExtensionConversion .swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/29.
//


import UIKit

class ExtensionConversion{
    func extensionConversion(_ url : String) -> UIImage{
        let imageURL = url.replacingOccurrences(of: ".svg", with: ".png")

        let url = URL(string: imageURL)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
}
