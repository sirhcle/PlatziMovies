//
//  ApiManager.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 27/01/23.
//

import Foundation

enum DataError: Error {
    case network(Error)
    case invalidResponse
    case invalidData
    case invalidURL
    case decoding
}

class ApiManager {
    
    typealias Completion<T> = (Result<T, DataError>) -> Void
        
    func getData<T: Codable>(for endPoint: EndPoint, completion: @escaping Completion<T>) {
        
        URLSession.shared.dataTask(with: URL(string: endPoint.getURL())!) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(.decoding))
            }
        }.resume()
    }
    
    func getData<T: Codable>(for endPoint: EndPoint, responseModel: T.Type) async throws -> Result<T, DataError> {
        
        guard let url = URL(string: endPoint.getURL()) else {
            throw DataError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decodableResponse =  try JSONDecoder().decode(T.self, from: data)
        
        return .success(decodableResponse)
    }
    
    
    
}
