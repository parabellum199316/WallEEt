//
//  YahooFinanceConvenience.swift
//  wallEEt
//
//  Created by ParaBellum on 10/14/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//

import SwiftyJSON
extension WebService{
    
    
    func getCurrencyExRates(_ completionHandler: @escaping (_ results:[ExchangeRate]?, _ error: Error?) -> Void){
        let selectString = "select * from yahoo.finance.xchange where pair in (\"USDRUB\",\"EURRUB\")"

        let parameters = ["q":selectString
            ,"format":"json"]
        let _ = taskForGETMethod(parameters: parameters) { (results , error) in
            if let error = error {
                completionHandler(nil, error)
            } else {
                var ratesArray:[ExchangeRate] = []
                if let rates = results?[WebService.JSONResponseKeys.Root][WebService.JSONResponseKeys.Results][WebService.JSONResponseKeys.Rates].arrayValue{
                    ratesArray = ExchangeRate.ratesFromJSON(json: rates)
                    print(ratesArray.count)
                    completionHandler(ratesArray,nil)
                } else {
                    completionHandler(nil, NSError(domain: "getCurrencyExRates", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getCurrencyExRates"]))
                }
                
            }
        }
        
        
    }
}
