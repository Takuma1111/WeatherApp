//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/09.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var telopLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    let weatherView = UIView()
    let cloudImage:UIImage = UIImage(named:"kumo-illust12")!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
            self.contentView.backgroundColor = UIColor.init(red: 137/255,green: 189/255, blue: 222/255, alpha: 1)
        
        let imageView = UIImageView(image:cloudImage)
        let screenWidth:CGFloat = contentView.frame.size.width
              let screenHeight:CGFloat = contentView.frame.size.height
        let imgWidth:CGFloat = cloudImage.size.width
        let imgHeight:CGFloat = cloudImage.size.height
        let scale:CGFloat = screenWidth / imgWidth
        let rect:CGRect = CGRect(x:20, y:0, width:imgWidth*scale*1.2, height:imgHeight*scale)
        imageView.frame = rect;
        imageView.center = CGPoint(x:screenWidth / 1.5, y:screenHeight/2)
    
        self.contentView.addSubview(imageView)
        self.contentView.sendSubviewToBack(imageView)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

