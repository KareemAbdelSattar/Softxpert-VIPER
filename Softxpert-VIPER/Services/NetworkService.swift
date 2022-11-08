//
//  NetworkService.swift
//  Softxpert-VIPER
//
//  Created by kareem chetoos on 27/10/2022.
//

import Alamofire
enum FetchError: Error {
    case failed
    case emptyData
    case noRecipes
    case textSearchInvalid
}

class NetworkService {
    static let shared = NetworkService()
    
    func fetch<T : Decodable>(userRouter: URLRequestConvertible,completionHandler: @escaping (Result<T?, FetchError>)->()){
        AF.request(userRouter).responseData { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                do{
                    let allItems = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(allItems))
                }catch{
                    completionHandler(.failure(.failed))
                }
            case .failure:
                completionHandler(.failure(.failed))
            }
        }
    }
}
