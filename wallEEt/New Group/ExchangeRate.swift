//
//  ExchangeRate.swift
//  wallEEt
//
//  Created by ParaBellum on 10/14/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import Foundation
import SwiftyJSON
struct  ExchangeRate {
    let name:String
    let rate:Double
    let time:String
    init(json:JSON) {
        self.name = json[WebService.JSONResponseKeys.RateName].stringValue
        self.rate = json[WebService.JSONResponseKeys.RateValue].doubleValue
        self.time = json[WebService.JSONResponseKeys.Time].stringValue
    }
    init?(dictionary:[String:Any]){
      let json =   JSON(dictionary: dictionary)
        self.init(json: json)
    }
    static func ratesFromJSON(json:[JSON]) -> [ExchangeRate]{
        var rates:[ExchangeRate] = []
        for rate in json{
            rates.append(ExchangeRate(json: rate))
        }
        return rates
    }
    var propertyListRepresentation:[String:Any]{
        return ["Name": self.name, "Rate": self.rate, "Time":self.time]
    }
}
