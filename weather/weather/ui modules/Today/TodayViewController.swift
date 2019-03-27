//
//  TodayViewController.swift
//  weather
//
//  Created Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

protocol TodayViewProtocol: class {
    func refresh(weather: ForecastModel)
    func shareImage() -> UIImage
    func showActivity()
    func hideActivity()
    func flashSuccess()
    func flashError()
}

class TodayViewController: UIViewController, ViperView {
    weak var presenter: TodayPresenterProtocol!
    
    @IBOutlet var mainView: CityWeatherView!
    @IBOutlet var humidityView: WeatherparametrView!
    
    @IBOutlet var pressureView: WeatherparametrView!
    @IBOutlet var precipitationView: WeatherparametrView!
    @IBOutlet var windSpeedView: WeatherparametrView!
    @IBOutlet var windDIrectionView: WeatherparametrView!
    
    @IBOutlet var shareButton: UIButton!

    @IBAction func shareAction(_ sender: Any) {
       self.presenter.shareAction()
    }
}
extension UIView {
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
extension TodayViewController: TodayViewProtocol {
    func flashSuccess() {
        HUD.flash(.success, delay: 1.0)
    }
    
    func flashError() {
        HUD.flash(.error, delay: 1.0)
    }
    
    func showActivity() {
        HUD.show(.progress)
    }
    
    func hideActivity() {
        HUD.hide()
    }
    
    func shareImage() -> UIImage {
        self.shareButton.isHidden = true
        let image = self.view.asImage()
        self.shareButton.isHidden = false
        return image
    }
    
    func refresh(weather: ForecastModel) {
        // main
        mainView.cityName = weather.city.name
        mainView.weatherId = weather.list.first?.weather.first?.id ?? 200
        mainView.weatherDescription = weather.list.first?.weather.first?.description ?? "Sunny"
        mainView.countryName = weather.city.country

        let main = weather.list.first?.main
        humidityView.parametrText = "\(main?.humidity ?? 0)%"
        pressureView.parametrText = "\(main?.pressure ?? 0) hPa"
        

        mainView.temperature = Float(main?.temp ?? 0)
        
        let rain = weather.list.first?.rain
        precipitationView.parametrText = "\(rain?.the3H ?? 0) mm"

        let wind = weather.list.first?.wind
        windSpeedView.parametrText = "\(wind?.speed ?? 0) m/s"
        
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index = Int((wind?.deg ?? 0) / 45.0) & 7
        let direction = directions[index]
        windDIrectionView.parametrText = "\(direction)"
    }
}
