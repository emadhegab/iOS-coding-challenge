//
//  InterfaceController.swift
//  GALWeatherWatchOS Extension
//
//  Created by Mohamed Emad Abdalla Hegab on 02.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var speechResultLabel: WKInterfaceLabel!
    @IBOutlet weak var iconImageView: WKInterfaceImage!

    @IBOutlet weak var tempLabel: WKInterfaceLabel!
    
    @IBOutlet weak var conditionLabel: WKInterfaceLabel!

    let interactor = ForecastInteractor()

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
//        interactor.getForecast(for: "Berlin", onComplete: { (forecast) in
//            print(forecast)
//        }) { (error) in
// 
//        }


    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func micButtonPressed() {
        
    }
}
