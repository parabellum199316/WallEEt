//
//  WebService.swift
//  wallEEt
//
//  Created by ParaBellum on 10/14/17.
//  Copyright © 2017 ParaBellum. All rights reserved.
//
import SwiftyJSON
import Foundation
class WebService:NSObject{
    
    class func shared() -> WebService {
        struct Singleton {
            static var sharedInstance = WebService()
        }
        return Singleton.sharedInstance
    }
    // shared session
    var session = URLSession.shared
    
    
    func taskForGETMethod(parameters: [String:String], completionHandlerForGET: @escaping (_ result: JSON?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 1. Set the parameters */
        
        
        /* 2/3. Build the URL, Configure the request */
        let request = URLRequest(url: URLFromParameters(parameters))
        print(request)
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
        
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        /* 7. Start the request */
        task.resume()
        return task
    }
    
    //MARK: Helpers
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: JSON?, _ error: NSError?) -> Void) {
        
        var parsedResult: JSON! = nil
        do {
            parsedResult = try JSON(data: data)
            print(parsedResult)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    private func URLFromParameters(_ parameters: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = WebService.Constants.ApiScheme
        components.host = WebService.Constants.ApiHost
        components.path = WebService.Constants.ApiPath
        components.queryItems = [URLQueryItem]()
    
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            components.queryItems!.append(queryItem)
        }
        let stringURL = components.url!.absoluteString
        let correctURLstring1 = stringURL.replacingOccurrences(of: ",", with: "%2C")
        let correctURLstring2 = correctURLstring1 + "&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        let correctURL = URL(string: correctURLstring2)!
        return correctURL
    }
}
