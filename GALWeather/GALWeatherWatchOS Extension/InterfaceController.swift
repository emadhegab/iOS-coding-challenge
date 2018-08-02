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
        self.presentTextInputController(withSuggestions: ["weather in Berlin", "weather in Cairo"], allowedInputMode: .plain) { [weak self] (result) in
            if let firstResult = result?.first as? String {
                let city = String((self?.interactor.getCityName(firstResult)) ?? "")
                self?.interactor.getForecast(for: city, onComplete: { [weak self] (forecast) in
                    self?.setupData(with: forecast)
                }) { (error) in

                }
            }
        }
    }

    private func setupData(with forecast: Forecast) {

        setupIcon(with: forecast.current.condition.iconURL())
        tempLabel.setText("\(forecast.current.tempC) °C")
        conditionLabel.setText(forecast.current.condition.text)
    }

    private func setupIcon(with url: URL?) {
        guard let url = url else { return }
        Queue.background.async {
            if let data = try? Data(contentsOf: url) {
                Queue.main.async { [weak self] in
                    self?.iconImageView.setImageData(data)
                }
            }
        }
    }
}
