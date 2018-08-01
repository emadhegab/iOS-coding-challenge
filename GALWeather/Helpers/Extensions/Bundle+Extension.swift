//
//  Bundle+Extension.swift
//  GALWeather
//
//  Created by Mohamed Emad Abdalla Hegab on 01.08.18.
//  Copyright © 2018 German Autolabs GmbH. All rights reserved.
//

import Foundation


extension Bundle {
    var apiBaseURL: String {
        return  Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
    }
}
