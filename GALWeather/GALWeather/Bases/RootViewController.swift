//
//  RootViewController.swift
//  GALWeather
//
//  Created by Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRouting()
    }


    func setupRouting() {
        ForecastRouter.route(from: self, animated: false)
    }
}
