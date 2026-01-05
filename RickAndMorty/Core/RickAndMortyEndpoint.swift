//
//  RickAndMortyEndpoint.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import Foundation

enum RickAndMortyEndpoint {
    case characterList(page: Int, name: String, filter: String)
    case characterDetail(id: Int)
    
    private static let baseUrl = "https://rickandmortyapi.com/api/character"

    var url: URL? {
        switch self {
        case .characterList(let page, let name, let filter):
            return URL(string: "\(RickAndMortyEndpoint.baseUrl)?page=\(page)&name=\(name)&status=\(filter)")
        case .characterDetail(let id):
            return URL(string: "\(RickAndMortyEndpoint.baseUrl)/\(id)")
        }
    }
}
