//
//  URLSessionProtocol.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/5/26.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
