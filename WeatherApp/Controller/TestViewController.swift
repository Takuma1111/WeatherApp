//
//  TestViewController.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/29.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://www.jma.go.jp/bosai/forecast/img/204.svg"
        print("変換前：",url)
        let after = url.replacingOccurrences(of: ".svg", with: ".png")
        print("変換後：",after)
        weatherImage.image = getImageByUrl(url: after)
        // Do any additional setup after loading the view.
    }
    

    func getImageByUrl(url: String) -> UIImage{
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
