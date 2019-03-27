//
//  OpenWeatherMapIcon.swift
//  weather
//
//  Created by Alexey Kubas on 3/27/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class OpenWeatherMapIcon: UIControl {
    @IBOutlet var weatherLabel: UILabel?
    @IBInspectable var weatherID: Int = 200 {
        didSet {
            updateInspectableValues()
        }
    }
    @IBInspectable var color: UIColor = .black {
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
        self.weatherLabel?.textColor = color
        // icon
        let key = "wi_owm_\(weatherID)"
        let wi = NSLocalizedString(key, tableName: "wi", bundle: Bundle(for: OpenWeatherMapIcon.self), value: "", comment: "")
        self.weatherLabel?.text = wi
    }
}
