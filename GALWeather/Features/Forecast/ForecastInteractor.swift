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

    let kSeparatorWord: String = "in "

    func getForecast(for city: String, onComplete: @escaping (Forecast) -> Void, onError: @escaping (ErrorItem) -> Void) {

        let environment = Environment(host: Constants.BASE_URL)
        let networkDispatcher = NetworkDispatcher(environment: environment, session: URLSession(configuration: .ephemeral))
        let forecastTask = ForecastTask<Forecast>(city: city)
        forecastTask.exeute(in: networkDispatcher, completed: onComplete, onError: onError)
    }

    func getCityName(_ resultString: String) -> Substring? {
        if let range = resultString.range(of: self.kSeparatorWord) {
            return resultString[range.upperBound...]
        }
        return nil
    }
}
