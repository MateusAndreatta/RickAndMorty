//
//  MockURLSession.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/5/26.
//

import Foundation
@testable import RickAndMorty

final class MockSession: URLSessionProtocol {
    var lastURL: URL?
    private let result: Result<(Data, URLResponse), Error>
    
    init(result: Result<(Data, URLResponse), Error>) {
        self.result = result
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        lastURL = url
        switch result {
        case .success(let pair): return pair
        case .failure(let error): throw error
        }
    }
}
