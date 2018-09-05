//
//  ViewController.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var restaurantModuleBtn: UIButton!
    
    @IBOutlet weak var weatherModuleBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = AppColors.AppThemeColor
        self.weatherModuleBtn.backgroundColor = AppColors.AppActionsColor
        self.restaurantModuleBtn.backgroundColor = AppColors.AppActionsColor
        
        self.weatherModuleBtn.layer.cornerRadius = 20.0
        self.restaurantModuleBtn.layer.cornerRadius = 20.0
        
        self.weatherModuleBtn.setTitle(AppStrings.WeatherActionTitle, for: .normal)
        self.restaurantModuleBtn.setTitle(AppStrings.RestaurantActionTitle, for: .normal)
        
        self.weatherModuleBtn.setTitleColor(AppColors.AppActionsTitleColor, for: .normal)
        self.restaurantModuleBtn.setTitleColor(AppColors.AppActionsTitleColor, for: .normal)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func weatherAction(_ sender: Any) {
        
        if let weatherController:UIViewController = StoryBoard.Weather.instantiateViewController(withIdentifier: AppStrings.WeatherController){
            self.navigationController?.pushViewController(weatherController, animated: true);
        }
        
    }
    @IBAction func restaurantAction(_ sender: Any) {
        
        if let restaurantController:UITableViewController = StoryBoard.Restaurant.instantiateViewController(withIdentifier: AppStrings.RestaurantController) as? UITableViewController{
            self.navigationController?.pushViewController(restaurantController, animated: true);
        }
    }
    
}

