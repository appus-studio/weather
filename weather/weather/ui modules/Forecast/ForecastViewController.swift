//
//  ForecastViewController.swift
//  weather
//
//  Created Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate

protocol ForecastViewProtocol: class {
    func reload()
}

class ForecastViewController: UIViewController, ViperView {
    weak var presenter: ForecastPresenterProtocol!
    @IBOutlet var tableView: UITableView!
}
extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = self.presenter.sectionDate(section: section)
        if date.weekday == Date().weekday {
            return "Today"
        }
        return date.weekdayName(.default)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.weathersGroupsCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.weatherItemsCount(group: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.forecastCell, for: indexPath) else {
            return UITableViewCell()
        }
        
        let weather = self.presenter.weather(index: indexPath.row, group: indexPath.section)
        
        let temp = Int(weather?.main.temp.rounded() ?? 0)
        cell.tempLabel?.text = "\(temp)℃"
        cell.weatherDescriptioneLabel?.text = weather?.weather.first?.description ?? "Clear"
        
        // Date
        let dateInterval = weather?.dt ?? 0
        let date = Date(timeIntervalSince1970: dateInterval)
        cell.timeLabel?.text = date.toString(.custom("HH:mm"))
        
        // icon
        let weatherID = weather?.weather.first?.id ?? 200
        let key = "wi_owm_\(weatherID)"
        let wi = NSLocalizedString(key, tableName: "wi", bundle: Bundle(for: OpenWeatherMapIcon.self), value: "", comment: "")
        cell.weatherIconLabel?.text = wi

        return cell
    } 
}
extension ForecastViewController: ForecastViewProtocol {
    func reload() {
        self.tableView?.reloadData()
    }
}
