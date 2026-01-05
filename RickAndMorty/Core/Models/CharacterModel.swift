//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let origin: OriginModel
    let episode: [String]
}
