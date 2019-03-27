//
//  UIViewController+ActivityIndicator.swift
//  weather
//
//  Created by Alexey Kubas on 3/27/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

protocol ActivityIndicator {
    func showActivityIndicator()
    func hideActivityIndicator()
}

extension ActivityIndicator where Self: UIViewController {
    func showActivityIndicator() {
    }
    
    func hideActivityIndicator() {
    }
    
}
