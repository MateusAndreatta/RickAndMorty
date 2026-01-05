//
//  Filter.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

enum Filter: String, CaseIterable, Identifiable {
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
    
    var id: String { self.rawValue }
    
    var filterValue: String {
        switch self {
        case .all:
            return ""
        default:
            return self.rawValue
        }
    }
}
