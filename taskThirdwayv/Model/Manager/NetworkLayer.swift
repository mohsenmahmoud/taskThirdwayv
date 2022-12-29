//
//  NetworkManager.swift
//  taskThirdwayv
//
//  Created by mohsen on 13/12/2022.
//

import Foundation
import UIKit
protocol RequestService {
    static func fetchDataRequest<T: Decodable>(urlString: String, type: T.Type, result completionHandler: @escaping (Result<T,Error>) -> ())
}

class NetworkManager : RequestService {
    static let shared = NetworkManager()
    let cache         = NSCache<NSString, UIImage>()
    static func fetchDataRequest<T>(urlString: String,  type: T.Type,result completionHandler: @escaping (Result<T, Error>) -> ()) where T : Decodable {
        guard let url = URL(string: urlString) else{ return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {return}
            print(data)
             do {
                let myNewObject = try JSONDecoder().decode(T.self, from: data)
                print(myNewObject)
                completionHandler(.success(myNewObject))
                   } catch let error {
                    completionHandler(.failure(error))
                       return
                   }
        }
        task.resume()
    }
}
