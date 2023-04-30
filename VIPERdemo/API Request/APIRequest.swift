//
//  APIRequest.swift
//  VIPERdemo
//
//  Created by Ankush on 31/03/23.
//

import Foundation

struct Constants {
    static let imageName = "chevron.down"
    static let fontName = "HelveticaNeue-Bold"
    static let listHeader = "JUPITICE LISTING"
}
struct APIs {
    static let firstApi = "https://naveen-test.jupitice.com/api/v1/help/topic/list"
}

enum APICallType: String {
    
    case GET = "GET"
    case PUT = "PUT"
    case POST = "POST"
    case DELETE = "DELETE"
}
//For dependency Inversion
protocol APICallProtocol {
    func genericApiCall<T: Decodable>(urlStr: String , type: APICallType, completionHandler: @escaping (Result<T, Error>) -> () )
}


class APIRequest : NSObject, APICallProtocol {
    func genericApiCall<T>(urlStr: String, type: APICallType, completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        
        let url = urlStr
        
        var urlRequest = URLRequest.init(url: URL.init(string: url)!)
        
        urlRequest.httpMethod = type.rawValue
        
       URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let data {
                
                if let placesData = try? JSONDecoder().decode(T.self, from: data) {
                    completionHandler(.success(placesData))
                } else {
                    if let error {
                        completionHandler(.failure(error))
                    }
                }
                
            }
        }.resume()
    }
 
    
}
