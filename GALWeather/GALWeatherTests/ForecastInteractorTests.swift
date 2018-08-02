//
//  ForecastInteractorTests.swift
//  GALWeatherTests
//
//  Created by Mohamed Emad Abdalla Hegab on 02.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//

import XCTest
@testable import GALWeather
class ForecastInteractorTests: XCTestCase {

    let timeout: TimeInterval = 10
    let goodCity: String = "Berlin"
    let badCity: String = "TK"
    var forecastInteractor: ForecastInteractor!
    override func setUp() {
        super.setUp()
        forecastInteractor = ForecastInteractor()
    }

    override func tearDown() {
        forecastInteractor = nil
        super.tearDown()
    }

    func testWeatherServiceReceivesCorrectResponse() {
        let expectation = self.expectation(description: "Retrieve forecast for a city")
        forecastInteractor.getForecast(for: goodCity, onComplete: { (forecast) in
            defer { expectation.fulfill() }

            XCTAssertEqual(forecast.location.name.lowercased(), "berlin")
        }) { (error) in

            defer { expectation.fulfill() }
            XCTFail("test shouldn't fail!")
        }


        waitForExpectations(timeout: timeout, handler: nil)
    }


    func testWeatherServiceReceivesError() {
        let expectation = self.expectation(description: "Retrieve forecast for a city")
        forecastInteractor.getForecast(for: badCity, onComplete: { (forecast) in
            defer { expectation.fulfill() }
            XCTFail("test shouldn't succeed!")

        }) { (error) in

            defer { expectation.fulfill() }
            XCTAssertEqual(error.code!.rawValue, 400)
        }


        waitForExpectations(timeout: timeout, handler: nil)
    }
}


