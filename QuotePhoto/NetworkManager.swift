//
//  NetworkManager.swift
//  QuotePhoto
//
//  Created by Mike Cameron on 2018-05-23.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {
    
    func fetchNewQuote(completion: @escaping (Data?, Error?) -> (Void)) -> (Void) {
        
        //URL COMPONENTS
        var quoteURLComponents = URLComponents()
        quoteURLComponents.scheme = "https"
        quoteURLComponents.host = "api.forismatic.com"
        quoteURLComponents.path = "/api/1.0/"
        
        //URL QUERY TOKENS
        let langQuery = URLQueryItem(name: "lang", value: "en")
        let quoteQuery = URLQueryItem(name: "method", value: "getQuote")
        let formatQuery = URLQueryItem(name: "format", value: "json")
        quoteURLComponents.queryItems = [langQuery, quoteQuery, formatQuery]
        
        //URL
        let url = quoteURLComponents.url
        
        //REQUEST
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        //SESSION
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        //TASK
        let task = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                //SUCCESS
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL Session Task Succeeded: HTTP \(statusCode)")
                completion(data, error)
            } else {
                //FAILURE
                print("URL Session Task Failed: HTTP \(error!.localizedDescription)")
            }
            
            
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    //IMAGE GETTING
     func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
     func downloadImage(completion: @escaping (UIImage?) -> Void)
    {
        print("Download Started")
        let url = URL.init(string: ("https://picsum.photos/300/?random"))
        getDataFromUrl(url: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url!.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                let img = UIImage(data: data);
                completion(img);
            }
        }
    }
}
