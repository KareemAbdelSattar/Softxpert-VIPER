//
//  RecipeAPI.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//

import Alamofire


enum RecipeRouter: URLRequestConvertible{
    
    case recipes(searchText: String, filter: String, from: Int, to: Int)
    
    var method: Alamofire.HTTPMethod{
        return .get
    }
    
    var path: String{
        switch self {
        case .recipes(let searchText, let filter, let from, let to):
            if filter.isEmpty {
                return "search?q=\(searchText)&app_id=8ece79a5&app_key=2e8ad91c7372258d6efa62ecae9f8797&from=\(from)&to=\(to)"
            }
            return "search?q=\(searchText)&app_id=8ece79a5&app_key=2e8ad91c7372258d6efa62ecae9f8797&from=\(from)&to=\(to)&health=\(filter)"
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let url: URL = try Constant.baseURL.asURL()
        let urlWithPath = (try url.appendingPathComponent(path).absoluteString.removingPercentEncoding?.asURL())!
            var urlRequest = URLRequest(url: urlWithPath)
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = TimeInterval(10*1000)
        return  urlRequest
    }
    
}
