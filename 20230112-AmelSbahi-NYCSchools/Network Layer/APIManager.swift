//  Created by Amel on 12/01/2023.
//

import Foundation

enum RequestErrors: Error {
    case badURL
    case dataNotFound
    case badData
    case jsonParsingFailed
    case badResponse
}

protocol APIManager {
    
    func call<T:Codable>(url: URL?, decoding: T.Type, completion: @escaping (Result<T, RequestErrors>)->())
}

final class RealAPIManager: APIManager {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func call<T:Codable>(url: URL?, decoding: T.Type, completion: @escaping (Result<T, RequestErrors>)->()) {
        
        guard let url = url else {
            completion(.failure(RequestErrors.badURL))
            print(" ===> : Url issue \(String(describing: url))")
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(.failure(RequestErrors.dataNotFound))
                print("===>:\(String(describing: error))")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(RequestErrors.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(RequestErrors.badData))
                return
            }
                        
            do {
                let jsonResult = try JSONDecoder().decode(decoding, from: data)
                
                completion(.success(jsonResult))
                
            } catch {
                completion(.failure(RequestErrors.jsonParsingFailed))
                print("===> : Request Error: \(error)")
            }
        }
        task.resume()
    }
}
