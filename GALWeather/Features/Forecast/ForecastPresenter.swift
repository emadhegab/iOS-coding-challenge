//
//  ForecastPresenter.swift
//  GALWeather
//
//  Created Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//


import UIKit

class ForecastPresenter: ForecastPresenterProtocol {


    weak private var view: ForecastViewProtocol?
    var interactor: ForecastInteractorProtocol?

    init(interface: ForecastViewProtocol, interactor: ForecastInteractorProtocol?) {
        self.view = interface
        self.interactor = interactor
    }

    func getForecast(for city: String) {
        interactor?.getForecast(for: city, onComplete: { (forecast) in
            print(forecast.current.condition.iconURL()?.absoluteURL ?? "")
        }, onError: { (error) in
            print(error)
        })
    }
}
