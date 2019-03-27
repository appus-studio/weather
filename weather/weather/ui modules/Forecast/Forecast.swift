//
//  Forecast.swift
//  weather
//
//  Created Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

protocol ForecastRouterProtocol: class {

}

class Forecast: ViperRouter<ForecastViewController, ForecastPresenter, ForecastInteractor> {
    override func assemble() {
        super.assemble()
        self.viperComponents.interactor.weatherService = Session.current
        Session.current.forecastUpdateDelegate = self.viperComponents.interactor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.title = Session.current.weather?.city.name ?? "Forecast"
    }
}

extension Forecast: ForecastRouterProtocol {

}
