//
//  CityWeatherView.swift
//  weather
//
//  Created by Alexey Kubas on 3/27/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CityWeatherView: UIControl {
    @IBOutlet var weatherIcon: OpenWeatherMapIcon?
    @IBOutlet var locationNameLabel: UILabel?
    @IBOutlet var weatherLabel: UILabel?
    
    @IBInspectable var cityName: String = "" {
        didSet {
            updateInspectableValues()
        }
    }
    @IBInspectable var countryName: String = "" {
        didSet {
            updateInspectableValues()
        }
    }
    @IBInspectable var weatherDescription: String = "" {
        didSet {
            updateInspectableValues()
        }
    }
    @IBInspectable var temperature: Float = 0 {
        didSet {
            updateInspectableValues()
        }
    }
    @IBInspectable var weatherId: Int = 200 {
        didSet {
            updateInspectableValues()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.fromNib()
        self.updateInspectableValues()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.fromNib()
        self.updateInspectableValues()
    }
    func updateInspectableValues() {
        weatherIcon?.weatherID = weatherId
        locationNameLabel?.text = "\(cityName), \(countryName)"
        
        let temp = Int(temperature.rounded())
        weatherLabel?.text = "\(temp)℃ | \(weatherDescription)"
    }
}
