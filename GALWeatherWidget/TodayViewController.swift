//
//  TodayViewController.swift
//  GALWeatherWidget
//
//  Created by Mohamed Emad Abdalla Hegab on 02.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var forecastButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    func setupView() {

        forecastButton.backgroundColor =  UIColor(red: 224 / 255, green: 166 / 255, blue: 35 / 255, alpha: 1)
        forecastButton.layer.cornerRadius =  forecastButton.frame.width / 2
        forecastButton.clipsToBounds = true
    }

    
    @IBAction func openAppPressed(_ sender: Any) {

        if let url = URL(string: "GALWeather://") {
            self.extensionContext?.open(url, completionHandler: nil)
        }
    }
}
