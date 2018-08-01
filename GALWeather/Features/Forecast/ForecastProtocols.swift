//
//  ForecastProtocols.swift
//  GALWeather
//
//  Created Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//


import Foundation
 
//MARK: Presenter -
protocol ForecastPresenterProtocol: class {

}

//MARK: Interactor -
protocol ForecastInteractorProtocol: class {

  var presenter: ForecastPresenterProtocol?  { get set }
}

//MARK: View -
protocol ForecastViewProtocol: class {

  var presenter: ForecastPresenterProtocol?  { get set }
}
