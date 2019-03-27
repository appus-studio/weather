//
//  ViewLifeCycleProtocol.swift
//
//  Created by Alexey Kubas on 4/17/18.
//  Copyright © 2018 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewLifeCycleProtocol {
    // Called after the view has been loaded.
    // For view controllers created in code, this is after -loadView.
    // For view controllers unarchived from a nib, this is after the view is set.
    func viewDidLoad()
    // Called when the view is about to made visible.
    // Default does nothing
    func viewWillAppear(_ animated: Bool)
    // Called when the view has been fully transitioned onto the screen.
    // Default does nothing
    func viewDidAppear(_ animated: Bool)
    // Called when the view is dismissed, covered or otherwise hidden.
    // Default does nothing
    func viewWillDisappear(_ animated: Bool)
    // Called after the view was dismissed, covered or otherwise hidden.
    // Default does nothing
    func viewDidDisappear(_ animated: Bool)
}

public extension ViewLifeCycleProtocol {
    func viewDidLoad() {}
    func viewWillAppear(_ animated: Bool) {}
    func viewDidAppear(_ animated: Bool) {}
    func viewWillDisappear(_ animated: Bool) {}
    func viewDidDisappear(_ animated: Bool) {}
}
