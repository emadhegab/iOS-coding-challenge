//
//  ForecastPresenter.swift
//  GALWeather
//
//  Created Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//


import UIKit
import Speech

class ForecastPresenter: ForecastPresenterProtocol {


    weak private var view: ForecastViewProtocol?
    var interactor: ForecastInteractorProtocol?

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))

    init(interface: ForecastViewProtocol, interactor: ForecastInteractorProtocol?) {
        self.view = interface
        self.interactor = interactor
        speechRecognizer?.delegate = self
    }

    func getForecast(for city: String) {
        interactor?.getForecast(for: city, onComplete: { (forecast) in
            print(forecast.current.condition.iconURL()?.absoluteURL ?? "")
        }, onError: { (error) in
            print(error)
        })
    }

    func speechRequestAuthorization() {

        SFSpeechRecognizer.requestAuthorization { (authStatus) in

            var isButtonEnabled = false

            switch authStatus {
            case .authorized:
                isButtonEnabled = true

            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")

            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")

            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }

            OperationQueue.main.addOperation() { [weak self] in
                self?.view?.toggleButton(isEnabled: isButtonEnabled)
            }
        }
    }

}
