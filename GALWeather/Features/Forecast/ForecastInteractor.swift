//
//  ForecastInteractor.swift
//  GALWeather
//
//  Created Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//


import MHNetwork

class ForecastInteractor: ForecastInteractorProtocol {

    weak var presenter: ForecastPresenterProtocol?

    func getForecast(for city: String, onComplete: @escaping (Forecast) -> Void, onError: @escaping (ErrorItem) -> Void) {

        let environment = Environment(host: Constants.BASE_URL)
        let networkDispatcher = NetworkDispatcher(environment: environment, session: URLSession(configuration: .default))
        let forecastTask = ForecastTask<Forecast>(city: city)
        forecastTask.exeute(in: networkDispatcher, completed: onComplete, onError: onError)
    }
}
