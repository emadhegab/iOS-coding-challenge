//
//  Forecast.swift
//  GALWeather
//
//  Created by Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    let current: CurrentForecast
}


struct CurrentForecast: Decodable {
    let tempC: Double
    let tempF: Double
    let condition: Condition

}

struct Condition: Decodable {
    let text: String
    let icon: String

    func iconURL() -> URL? {
        guard !icon.isEmpty else { return nil }

        let validURLString = String("https:\(icon)") // api return url with 2 slashes in the begenning.. so we will append https: Before it as a dirty hack
        let url = URL(string: validURLString) ?? nil
        return url
    }
}
