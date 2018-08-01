//
//  ForecastRequests.swift
//  GALWeather
//
//  Created by Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//

import MHNetwork

enum ForecastRequests: Request {

    case getForcast(forCity: String)

    var path: String {
        switch self {
        case .getForcast(_):
            return "forecast.json"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: RequestParams {
        switch self {
        case .getForcast(let city):
           let params = ["q": city, "key": Constants.FORCAST_API_KEY]
            return .url(params)
        }
    }

    var headers: [String : Any]? {
        return nil
    }


}
