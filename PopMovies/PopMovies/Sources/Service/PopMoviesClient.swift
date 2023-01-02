//
//  PopMoviesClient.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

class PopMoviesClient: PopMoviesClientProtocol {
    func makeRequest<T: Decodable>(endpoint: ApiEndpoints, _ completion: @escaping (Result<T, ErrorState>) -> Void) {
        if let url = makeUrlRequest(endpoint: endpoint) {
            let task = URLSession.shared.dataTask(with: url) { data, response, _ in
                guard let data = data else {
                    completion(
                        .failure(
                            .generic(
                                "Unexpected failure!\nUnable to recover data\nfrom the server."
                            )
                        )
                    )
                    return
                }
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                        case 200...299:
                            do {
                                let object: T = try data.decodeFromApi()
                                completion(.success(object))
                            } catch {
                                completion(
                                    .failure(
                                        .generic(
                                            "That's an error to decode JSON"
                                        )
                                    )
                                )
                            }
                            return
                        case 300...399:
                            print(response.debugDescription)
                            completion(
                                .failure(
                                    .redirectError(
                                        "That's a redirect error!")
                                )
                            )
                            return
                        case 400...499:
                            print(response.debugDescription)
                            completion(
                                .failure(
                                    .clientError(
                                        "That's a client error!")
                                )
                            )
                            return
                        case 500...599:
                            print(response.debugDescription)
                            completion(
                                .failure(
                                    .serverError(
                                        "That's a server error!")
                                )
                            )
                            return
                        default:
                            return
                    }
                } else {
                    completion(
                        .failure(
                            .generic(
                                "Unable to recover response"
                            )
                        )
                    )
                }
            }
            task.resume()
        } else {
            completion(
                .failure(
                    .generic(
                        "Failed to make URL request")
                )
            )
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
