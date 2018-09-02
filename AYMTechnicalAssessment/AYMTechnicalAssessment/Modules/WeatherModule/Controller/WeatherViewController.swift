//
//  WeatherViewController.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet var countryNamelbl: UILabel!
    @IBOutlet weak var weekDaylbl: UILabel!
    @IBOutlet var weatherDesclbl: UILabel!
    @IBOutlet var weatherIconImgView: UIImageView!
    @IBOutlet var weatherValuelbl: UILabel!
    @IBOutlet var preciptationValuelbl: UILabel!
    @IBOutlet var preciptationlbl: UILabel!
    @IBOutlet var humidityValuelbl: UILabel!
    @IBOutlet var humiditylbl: UILabel!
    @IBOutlet var windValuelbl: UILabel!
    @IBOutlet var windlbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColors.AppThemeColor
        self.setColorsToLabels()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func setColorsToLabels(){
        self.countryNamelbl.textColor = AppColors.WeatherDarkColor
        self.weekDaylbl.textColor = AppColors.WeatherDarkMediumColor
        self.weatherDesclbl.textColor = AppColors.WeatherDarkMediumColor
        self.weatherValuelbl.textColor = AppColors.WeatherDarkColor
        self.preciptationValuelbl.textColor = AppColors.WeatherDarkColor
        self.preciptationlbl.textColor = AppColors.WeatherDarkMediumColor
        self.humidityValuelbl.textColor = AppColors.WeatherDarkColor
        self.humiditylbl.textColor = AppColors.WeatherDarkMediumColor
        self.windValuelbl.textColor = AppColors.WeatherDarkColor
        self.windlbl.textColor = AppColors.WeatherDarkMediumColor
    }
}
