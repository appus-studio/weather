//
//  Sesion.swift
//  weather
//
//  Created by Alexey Kubas on 3/27/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import CoreLocation
import FirebaseDatabase
import CodableFirebase
import SwiftDate

class Session: NSObject, WeatherProtocol {
    static var current = Session()
    
    let weatherService = OpenweathermapService(apiKey: "7a574fe9f553a9bc3d313f360823eb67")
    
    var weather: ForecastModel?
    
    weak var todayUpdateDelegate: UpdateWeatherProtocol?
    weak var forecastUpdateDelegate: UpdateWeatherProtocol?
    
    lazy var locationManager: CLLocationManager = {
        // Do any additional setup after loading the view, typically from a nib.
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        return locationManager
    }()

    var location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51, longitude: 0)

    func refreshWeather(callback:@escaping (ForecastModel?, URLResponse?, Error?) -> Void) {
        weatherService.forecast(coordinate: location) { (forecast, responce, error) in
            self.weather = forecast
            callback(forecast, responce, error)
            
            self.todayUpdateDelegate?.weatherWasUpdated()
            self.forecastUpdateDelegate?.weatherWasUpdated()
            
            // Store to Firebase
            let ref: DatabaseReference! = Database.database().reference()
            let data = try? FirebaseEncoder().encode(forecast?.list.first)
            let key = Date().toISO()
            let id = UIDevice.current.identifierForVendor!.uuidString
            ref.child("users").child(id).child(key).setValue(data)
        }
    }
}
extension Session: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        self.location = locations.last?.coordinate ?? CLLocationCoordinate2D(latitude: 51, longitude: 0)
        self.refreshWeather { (_, _, _) in
            
        }
    }
}
extension Session: LocationServiceProtocol {
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
}
protocol LocationServiceProtocol: class {
    func startUpdatingLocation()
}
protocol UpdateWeatherProtocol: class {
    func weatherWasUpdated()
}
protocol WeatherProtocol: class {
    var weather: ForecastModel? {get}
    func refreshWeather(callback: @escaping (ForecastModel?, URLResponse?, Error?) -> Void)
}
