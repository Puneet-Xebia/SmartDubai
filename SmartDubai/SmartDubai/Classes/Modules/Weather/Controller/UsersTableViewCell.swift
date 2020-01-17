//
//  UsersTableViewCell.swift
//  Assignment
//
//  Created by Kuldeep Saini on 25/10/19.
//  Copyright © 2019 Org. All rights reserved.
//

import UIKit

final class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblDesc: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func bindCellData(_ weatherData : Weather){
        
  
        if let name = weatherData.main.minTemperature{
            
            print("Min Temp: \(name)")
            self.lblMinTemp.text = "Min Temp: \(name)"
        }
        
        if let repo = weatherData.main.maxTemperature{
            lblMaxTemp.text = "Max Temp: \(repo)"
        }
        
        if let repo = weatherData.wind.windSpeed{
                lblWindSpeed.text = "Wind Speed: \(repo)"
            }
        
         if let weatherDec = weatherData.weather?[0]
         {
            lblDesc.text = weatherDec.weatherDec
        }
    
    }
    
    
      func bindCellForecastData(_ weatherData : List){
          
    
          if let name = weatherData.main.minTemperature{
              
              print("Min Temp: \(name)")
              self.lblMinTemp.text = "Min Temp: \(name)"
          }
          
          if let repo = weatherData.main.maxTemperature{
              lblMaxTemp.text = "Max Temp: \(repo)"
          }
          
          if let repo = weatherData.wind.windSpeed{
                  lblWindSpeed.text = "Wind Speed: \(repo)"
              }
        
        if let weatherDec = weatherData.weather?[0]
               {
                  lblDesc.text = weatherDec.weatherDec
              }
        
      }
}
