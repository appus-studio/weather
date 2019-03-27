//
//  Today.swift
//  weather
//
//  Created Alexey Kubas on 3/26/19.
//  Copyright © 2019 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

protocol TodayRouterProtocol: class {
    func shareImage(image: UIImage)
}

class Today: ViperRouter<TodayViewController, TodayPresenter, TodayInteractor> {
    override func assemble() {
        super.assemble()
        self.viperComponents.interactor.weatherService = Session.current
        Session.current.todayUpdateDelegate = self.viperComponents.interactor
    }
}

extension Today: TodayRouterProtocol {
    func shareImage(image: UIImage) {
        let activityItem: [AnyObject] = [image as AnyObject]
        
        let avc = UIActivityViewController(activityItems: activityItem as [AnyObject], applicationActivities: nil)
        
        self.present(avc, animated: true, completion: nil)
    }
    
    
}
