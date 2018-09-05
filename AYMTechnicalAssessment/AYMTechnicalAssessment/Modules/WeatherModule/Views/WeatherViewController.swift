//
//  WeatherViewController.swift
//  AYMTechnicalAssessment
//
//  Created by Waseem Shahzad on 9/2/18.
//  Copyright © 2018 Waseem Shahzad. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class WeatherViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var countryNamelbl: UILabel!
    @IBOutlet weak var weekDaylbl: UILabel!
    @IBOutlet weak var weatherDesclbl: UILabel!
    @IBOutlet weak var weatherIconlbl: UILabel!
    @IBOutlet weak var weatherValuelbl: UILabel!
    @IBOutlet weak var preciptationValuelbl: UILabel!
    @IBOutlet weak var preciptationlbl: UILabel!
    @IBOutlet weak var humidityValuelbl: UILabel!
    @IBOutlet weak var humiditylbl: UILabel!
    @IBOutlet weak var windValuelbl: UILabel!
    @IBOutlet weak var windlbl: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    
    @IBOutlet weak var fahrenheitBtn: UIButton!
    @IBOutlet weak var degreeCentiBtn: UIButton!
    
    var weatherDataSource:[ForecastViewModel]?
    
    var flowLayout: UICollectionViewFlowLayout {
        let _flowLayout = UICollectionViewFlowLayout()
        _flowLayout.itemSize = CGSize(width: 60, height: 150)
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        _flowLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        _flowLayout.minimumInteritemSpacing = 0.0
        return _flowLayout
    }
    
    var viewModel: WeatherViewModel? {
        didSet {
            viewModel?.location.observe {
                [unowned self] in
                self.countryNamelbl.text = $0
            }
            
            viewModel?.iconText.observe {
                [unowned self] in
                self.weatherIconlbl.text = $0
            }
            
            viewModel?.temperature.observe {
                [unowned self] in
                self.weatherValuelbl.text = $0
            }
            viewModel?.weatherDesc.observe {
                [unowned self] in
                self.weatherDesclbl.text = $0
            }
            viewModel?.humidity.observe {
                [unowned self] in
                self.humidityValuelbl.text = $0
                self.humidityValuelbl.attributedText = Utility.getMutableAttributedString(leftString: self.humidityValuelbl.text! , rightString: "%")
                
            }
            viewModel?.wind.observe {
                [unowned self] in
                self.windValuelbl.text = $0
                self.windValuelbl.attributedText = Utility.getMutableAttributedString(leftString: self.windValuelbl.text! , rightString: "Km/h")
            }
            viewModel?.percipitation.observe {
                [unowned self] in
                self.preciptationValuelbl.text = $0
                self.preciptationValuelbl.attributedText = Utility.getMutableAttributedString(leftString: self.preciptationValuelbl.text! , rightString: "%")
            }
            viewModel?.weekDay.observe {
                [unowned self] in
                self.weekDaylbl.text = $0
            }
            
            viewModel?.forecasts.observe {
                [unowned self] (forecastViewModels) in
                if forecastViewModels.count >= 1 {
                    self.weatherDataSource = NSMutableArray(array: forecastViewModels) as? [ForecastViewModel]
                    self.forecastCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = AppColors.AppThemeColor
        self.setColorsToLabels()
        self.forecastCollectionView.collectionViewLayout = flowLayout
        weatherStackView.addBackground(color: AppColors.AppThemeColor)
        viewModel = WeatherViewModel()
        viewModel?.startLocationService()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Weather ForecastColletion Data Source methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = self.weatherDataSource?.count {
            return count
        } else {
            return 0
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell:ForecastCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppStrings.ReusableIdentifier, for: indexPath as IndexPath) as! ForecastCollectionViewCell
        let forcastViewModel = self.weatherDataSource![indexPath.row]
        cell.weekDaylbl.text = forcastViewModel.weekDay.uppercased()
        cell.weahterIcon.text = forcastViewModel.iconText
        cell.maxMinTemplbl.attributedText = Utility.getDifferentColorsOfString(leftString: forcastViewModel.tempMax + " " , rightString: forcastViewModel.tempMin) 
        cell.timelbl.text = forcastViewModel.time
        
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
         // make cell more visible in our example project
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
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
        self.degreeCentiBtn.setTitle(TemperatureCodes.degreeSign, for: .normal)
        self.fahrenheitBtn.setTitle(TemperatureCodes.fahrenheitSign, for: .normal)
        self.degreeCentiBtn.setTitleColor(AppColors.WeatherDarkColor, for: .normal)
        self.fahrenheitBtn.setTitleColor(AppColors.WeatherHalfDarkColor, for: .normal)
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.degreeTemp)
        UserDefaults.standard.set(false, forKey: UserDefaultKeys.fahrenheitTemp)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func celsuisAction(_ sender: Any) {
        viewModel?.convertTempFromCelsiusToFahrenheit()
            viewModel?.temperature.observe {
                [unowned self] in
                self.weatherValuelbl.text = $0
                self.fahrenheitBtn.setTitleColor(AppColors.WeatherHalfDarkColor, for: .normal)
                self.degreeCentiBtn.setTitleColor(AppColors.WeatherDarkColor, for: .normal)
            }
    }
    
    @IBAction func fahrenheitAction(_ sender: Any) {
        viewModel?.convertTempFromFahrenheitToCelsius()
            viewModel?.temperature.observe {
                [unowned self] in
                self.weatherValuelbl.text = $0
                self.fahrenheitBtn.setTitleColor(AppColors.WeatherDarkColor, for: .normal)
                self.degreeCentiBtn.setTitleColor(AppColors.WeatherHalfDarkColor, for: .normal)
                
            }
    }
    
}



