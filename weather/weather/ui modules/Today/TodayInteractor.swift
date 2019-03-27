//
//  TodayInteractor.swift
//  weather
//
//  Created Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

protocol TodayInteractorProtocol: class {
    var weather: ForecastModel? {get}
    func refreshCurrentWeather(callback: @escaping (ForecastModel?, URLResponse?, Error?) -> Void)
}

final class TodayInteractor: ViperInteractor {
    weak var presenter: TodayPresenterProtocol!
    var weatherService: WeatherProtocol!
}

extension TodayInteractor: UpdateWeatherProtocol {
    func weatherWasUpdated() {
        self.presenter.weatherWasUpdated()
    }
}

extension TodayInteractor: TodayInteractorProtocol {
    func refreshCurrentWeather(callback: @escaping (ForecastModel?, URLResponse?, Error?) -> Void) {
        self.weatherService.refreshWeather(callback: callback)
    }
    
    var weather: ForecastModel? {
        return self.weatherService.weather
    }
}
