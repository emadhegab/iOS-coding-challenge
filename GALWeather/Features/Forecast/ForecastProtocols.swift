//
//  ForecastProtocols.swift
//  GALWeather
//
//  Created Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//


import MHNetwork
 
//MARK: Presenter -
protocol ForecastPresenterProtocol: class {
    func getForecast(for city: String)
    func speechRequestAuthorization()
    func startRecording()
}

//MARK: Interactor -
protocol ForecastInteractorProtocol: class {

    var presenter: ForecastPresenterProtocol?  { get set }
    func getForecast(for city: String, onComplete: @escaping (Forecast) -> Void, onError: @escaping (ErrorItem) -> Void)
}

//MARK: View -
protocol ForecastViewProtocol: class {
    var presenter: ForecastPresenterProtocol?  { get set }
    func toggleButton(isEnabled: Bool)
    func setTextResult(_ text: String)
    func setButtonText(_ text: String)
}
