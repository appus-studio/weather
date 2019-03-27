//
//  ForecastPresenter.swift
//  weather
//
//  Created Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation

protocol ForecastPresenterProtocol: class {
    func weathersGroupsCount() -> Int
    func weather(index: Int, group: Int) -> List?
    func weatherItemsCount(group: Int) -> Int
    func sectionDate(section: Int) -> Date
    
    func weatherWasUpdated()
}

final class ForecastPresenter: ViperPresenter {
    weak var view: ForecastViewProtocol!
    weak var interactor: ForecastInteractorProtocol!
    weak var router: ForecastRouterProtocol!
}

extension ForecastPresenter: ViewLifeCycleProtocol {
    func viewWillAppear(_ animated: Bool) {
        self.interactor.reGrouped()
        self.view.reload()
    }
}

extension ForecastPresenter: ForecastPresenterProtocol {
    func weatherWasUpdated() {
        self.interactor.reGrouped()
        self.view.reload()
    }
    
    func sectionDate(section: Int) -> Date {
        return self.interactor.weathersGroups[section].date
    }
    
    func weathersGroupsCount() -> Int {
        return self.interactor.weathersGroups.count
    }
    
    func weather(index: Int, group: Int) -> List? {
        return self.interactor.weathersGroups[group].weathers[index]
    }
    
    func weatherItemsCount(group: Int) -> Int {
        return self.interactor.weathersGroups[group].weathers.count
    }
    
}
