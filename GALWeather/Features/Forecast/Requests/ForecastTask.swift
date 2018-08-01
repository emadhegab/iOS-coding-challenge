//
//  ForecastTask.swift
//  GALWeather
//
//  Created by Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//

import MHNetwork

class ForecastTask<T: Decodable>: Operations {

    let city: String

    init(city: String) {
        self.city = city
    }

    var request: Request {
        return ForecastRequests.getForcast(forCity: self.city)
    }

    func exeute(in dispatcher: Dispatcher, completed: @escaping (T) -> Void, onError: @escaping (ErrorItem) -> Void) {

        do {
            try dispatcher.execute(request: self.request, completion: { (response) in
                switch response {
                case .data(let data):
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let object = try decoder.decode(T.self, from: data)
                        completed(object)
                    } catch let error {
                        onError((nil, error, nil))
                    }
                    break
                case .error(let error):
                    onError(error)
                    break
                }
            }, onError: onError)
        } catch {
            onError((nil, error, nil))
        }
    }

}
