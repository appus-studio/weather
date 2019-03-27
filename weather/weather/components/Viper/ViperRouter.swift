//
//  ViperRouter.swift
//
//  Created by Alexey Kubas on 4/17/18.
//  Copyright © 2018 Appus Studio LP. All rights reserved.
//

import Foundation
import UIKit

public protocol ViperView where Self: UIViewController {
    associatedtype Presenter
    var presenter: Presenter! { get set }
}

public protocol ViperPresenter: class, ViewLifeCycleProtocol {
    associatedtype Router
    associatedtype View
    associatedtype Interactor
    var view: View! { get set }
    var interactor: Interactor! { get set }
    var router: Router! { get set }
    init()
}

public protocol ViperInteractor: class {
    associatedtype Presenter
    var presenter: Presenter! { get set }
    init()
}

open class ViperRouter<View: ViperView, Presenter: ViperPresenter, Interactor: ViperInteractor>: UIViewController {
    // MARK: Components
    public var viperComponents = VIPERComponents()

    public struct VIPERComponents {
        public var view: View!
        public var interactor: Interactor!
        public var presenter: Presenter!

        init() {
            let storyboardName = String(describing: View.self)
            let bundle = Bundle(for: View.self)

            guard let viewController = UIStoryboard(name: storyboardName, bundle: bundle).instantiateInitialViewController() as? View else {
                fatalError("Please check your storyboard for '\(storyboardName)'")
            }

            view = viewController
            interactor = Interactor()
            presenter = Presenter()
        }
    }

    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.assemble()
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        self.assemble()
    }

    // MARK: lifecycle
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viperComponents.presenter.viewWillAppear(animated)
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viperComponents.presenter.viewDidAppear(animated)
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viperComponents.presenter.viewWillDisappear(animated)
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viperComponents.presenter.viewDidDisappear(animated)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.viperComponents.view.view.frame = self.view.bounds
        self.addChild(self.viperComponents.view)
        self.viperComponents.view.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.view.addSubview(self.viperComponents.view.view)
        self.viperComponents.presenter.viewDidLoad()
    }

    // MARK: Assembler
    open func assemble() {

        guard let viperView = self.viperComponents.view as? Presenter.View,
            let viperInteractor = self.viperComponents.interactor as? Presenter.Interactor,
            let viperRouter = self as? Presenter.Router,
            let viperViewPresenter = self.viperComponents.presenter as? View.Presenter,
            let viperInteractorPresenter = self.viperComponents.presenter as? Interactor.Presenter else {
            fatalError("Incompatible types.")
        }

        self.viperComponents.presenter.view = viperView
        self.viperComponents.presenter.interactor = viperInteractor
        self.viperComponents.presenter.router = viperRouter
        self.viperComponents.view.presenter = viperViewPresenter
        self.viperComponents.interactor.presenter = viperInteractorPresenter
    }
}
