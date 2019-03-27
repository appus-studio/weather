//
//  OpenweathermapService.swift
//  weather
//
//  Created by Alexey Kubas on 3/27/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import CoreLocation

public class OpenweathermapService {
    public enum TemperatureFormat: String {
        case Celsius = "metric"
        case Fahrenheit = "imperial"
    }
    
    public var apiKey: String
    public var apiVersion: String
    public var language: String
    public var temperatureFormat: TemperatureFormat
    
    private struct Const {
        static let basePath = "http://api.openweathermap.org/data/"
    }
    
    // MARK: -
    // MARK: Initialization
    
    public convenience init(apiKey: String) {
        self.init(apiKey: apiKey, language: "en", temperatureFormat: .Celsius, apiVersion: "2.5")
    }
    
    public convenience init(apiKey: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey, language: "en", temperatureFormat: temperatureFormat, apiVersion: "2.5")
    }
    
    public convenience init(apiKey: String, language: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey, language: language, temperatureFormat: temperatureFormat, apiVersion: "2.5")
    }
    
    public init(apiKey: String, language: String, temperatureFormat: TemperatureFormat, apiVersion: String) {
        self.apiKey = apiKey
        self.temperatureFormat = temperatureFormat
        self.apiVersion = apiVersion
        self.language = language
    }
    
    // MARK: -
    // MARK: Retrieving current weather data
    
    func currentWeather(coordinate: CLLocationCoordinate2D, callback: @escaping (CurrentWeather?, URLResponse?, Error?) -> Void) {
        let coordinateString = "lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        callCurrentWeather(method: "/weather?\(coordinateString)", callback: callback)
    }
    
    // MARK: -
    // MARK: Retrieving forecast
    
    func forecast(coordinate: CLLocationCoordinate2D, callback:@escaping (ForecastModel?, URLResponse?, Error?) -> Void) {
        callForecastWeather(method: "/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)", callback: callback)
    }
    
    // MARK: -
    // MARK: Call the api
    private func url(method: String) -> URL {
        let urlString = Const.basePath + apiVersion + method + "&APPID=\(apiKey)&lang=\(language)&units=\(temperatureFormat.rawValue)"
        return URL(string: urlString)!
    }
    private func callCurrentWeather(method: String, callback: @escaping (CurrentWeather?, URLResponse?, Error?) -> Void) {
        let currentQueue = OperationQueue.current
        let task = URLSession.shared.currentWeatherTask(with: url(method: method), completionHandler: { (currentWeather, response, error) in
            currentQueue?.addOperation {
                callback(currentWeather, response, error)
            }
        })
        task.resume()
    }
    private func callForecastWeather(method: String, callback: @escaping (ForecastModel?, URLResponse?, Error?) -> Void) {
        let currentQueue = OperationQueue.current
        let task = URLSession.shared.forecastModelTask(with: url(method: method), completionHandler: { (forecast, response, error) in
            currentQueue?.addOperation {
                callback(forecast, response, error)
            }
        })
        task.resume()
    }
}
