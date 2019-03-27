//
//  TodayPresenter.swift
//  weather
//
//  Created Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import CoreLocation

protocol TodayPresenterProtocol: class {
    func shareAction()
    func weatherWasUpdated()
}

final class TodayPresenter: ViperPresenter {
    weak var view: TodayViewProtocol!
    weak var interactor: TodayInteractorProtocol!
    weak var router: TodayRouterProtocol!
    
}

extension TodayPresenter: ViewLifeCycleProtocol {
    func viewDidLoad() {
        self.view.showActivity()
        self.interactor.refreshCurrentWeather { (weather, _, error) in
            if error == nil, let weather = weather {
                self.view.refresh(weather: weather)
                self.view.flashSuccess()
            } else {
                self.view.flashError()
            }
        }
    }
}

extension TodayPresenter: TodayPresenterProtocol {
    func weatherWasUpdated() {
        guard let weather = self.interactor.weather else {
            return
        }
        self.view.refresh(weather: weather)
    }
    
    func shareAction() {
        let image = self.view.shareImage()
        self.router.shareImage(image: image)
    }
}
