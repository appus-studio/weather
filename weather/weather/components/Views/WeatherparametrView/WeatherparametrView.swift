//
//  WeatherparametrView.swift
//  weather
//
//  Created by Alexey Kubas on 3/27/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class WeatherparametrView: UIControl {
    @IBOutlet var parametrIcon: UILabel?
    @IBOutlet var parametrLabel: UILabel?

    @IBInspectable var parametrText: String = "" {
        didSet {
            updateInspectableValues()
        }
    }
    @IBInspectable var iconText: String = "" {
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
        parametrLabel?.text = parametrText
        parametrIcon?.text = iconText
    }
}
