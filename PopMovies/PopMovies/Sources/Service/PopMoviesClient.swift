//
//  PopMoviesClient.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

class PopMoviesClient: PopMoviesClientProtocol {
    func makeRequest<T: Decodable>(endpoint: ApiEndpoints, _ completion: @escaping (Result<T, MovieErrorState>) -> Void) {
        if let url = makeUrlRequest(endpoint: endpoint) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    completion(.failure(.generic("Unexpected failure, unable to recover data from the server.")))
                    return
                }
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                        case 200...299:
                            do {
                                let object: T = try data.decodeFromApi()
                                completion(.success(object))
                            } catch {
                                completion(.failure(.generic("\(error.localizedDescription)")))
                            }
                            return
                        case 300...399:
                            print(response.debugDescription)
                            completion(.failure(.redirectError))
                            return
                        case 400...499:
                            print(response.debugDescription)
                            completion(.failure(.clientError))
                            return
                        case 500...599:
                            print(response.debugDescription)
                            completion(.failure(.serverError))
                            return
                        default:
                            return
                    }
                } else {
                    completion(.failure(.generic("\(String(describing: error?.localizedDescription))")))
                }
            }
            task.resume()
        } else {
            completion(.failure(.generic("Failed to make url request")))
        }
    }

    private func makeUrlRequest(endpoint: ApiEndpoints) -> URLRequest? {
        guard let url = buildUrlWith(endpoint: endpoint) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        return urlRequest
    }

    private func buildUrlWith(endpoint: ApiEndpoints) -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = endpoint.host
        component.path = endpoint.path
        component.queryItems = endpoint.query
        return component.url
    }
}


