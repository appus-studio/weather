//
//  ForecastInteractor.swift
//  weather
//
//  Created Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

protocol ForecastInteractorProtocol: class {
    var weathersGroups: [ForecastGroupedData] {get}
    func refreshCurrentWeather(callback: @escaping (ForecastModel?, URLResponse?, Error?) -> Void)
    func reGrouped()
}

class ForecastGroupedData {
    var date: Date = Date()
    var weathers: [List] = [List]()
}

final class ForecastInteractor: ViperInteractor {
    weak var presenter: ForecastPresenterProtocol!
    
    var weatherService: WeatherProtocol!
    
    var weathersGroups: [ForecastGroupedData] = [ForecastGroupedData]()
}
extension ForecastInteractor: UpdateWeatherProtocol {
    func weatherWasUpdated() {
        self.presenter.weatherWasUpdated()
    }
}
extension ForecastInteractor: ForecastInteractorProtocol {
    func refreshCurrentWeather(callback: @escaping (ForecastModel?, URLResponse?, Error?) -> Void) {
        self.weatherService.refreshWeather(callback: callback)
    }
    func reGrouped() {
        weathersGroups = [ForecastGroupedData]()
        weathersGroups.append(ForecastGroupedData())
        guard let weathers = self.weatherService.weather?.list else {
            return
        }
        var date = Date(timeIntervalSince1970: weathers.first?.dt ?? 0)
        weathersGroups.last?.date = date
        for weather in weathers {
            let currentDate = Date(timeIntervalSince1970: weather.dt)
            if currentDate.weekday != date.weekday {
                weathersGroups.append(ForecastGroupedData())
                weathersGroups.last?.date = Date(timeIntervalSince1970: weather.dt)
            }
            weathersGroups.last?.weathers.append(weather)
            date = weathersGroups.last?.date ?? Date()
        }
    }
    var weather: ForecastModel? {
        return self.weatherService.weather
    }
}
