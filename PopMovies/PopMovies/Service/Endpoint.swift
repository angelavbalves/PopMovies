//
//  EndpointProtocol.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import Foundation

protocol Endpoint {
    var host: String { get }
    var method: String { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
}
