//
//  ForecastRouter.swift
//  GALWeather
//
//  Created Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//


import UIKit

class ForecastRouter {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ForecastViewController(nibName: nil, bundle: nil)
        let interactor = ForecastInteractor()
        let router = ForecastRouter()
        let presenter = ForecastPresenter(interface: view, interactor: interactor)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
