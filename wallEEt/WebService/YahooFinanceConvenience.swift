//
//  YahooFinanceConvenience.swift
//  wallEEt
//
//  Created by ParaBellum on 10/14/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//


extension WebService{
    
    
    func getCurrencyExRates(_ completionHandler: @escaping (_ results:[String:String]?, _ error: Error?) -> Void){
        let parameters = ["q":"select * from yahoo.finance.xchange where pair in ('USDRUB','EURRUB')","format":"json"]
        let _ = taskForGETMethod(parameters: parameters) { (results, error) in
            if let error = error {
                completionHandler(nil, error)
            } else {
                
                if let results = results?[TMDBClient.JSONResponseKeys.MovieResults] as? [[String:AnyObject]] {
                    
//                    let movies = TMDBMovie.moviesFromResults(results)
//                    completionHandlerForWatchlist(movies, nil)
                } else {
                    completionHandler(nil, NSError(domain: "getCurrencyExRates", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getCurrencyExRates"]))
                }
        }
    }
    
    
    
}
