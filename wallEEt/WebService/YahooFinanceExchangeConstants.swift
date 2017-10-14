//
//  YahooFinanceExchangeConstants.swift
//  wallEEt
//
//  Created by ParaBellum on 10/14/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//


extension WebService{
    
    struct Constants {
        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "query.yahooapis.com"
        static let ApiPath = "/v1/public/yql"
    }
    struct JSONResponseKeys{
        static let Results = "results"
        static let Rates = "rate"
        static let RateName = "Name"
        static let RateValue = "Rate"
        static let Time = "Time"
    }
    
    
    
}
