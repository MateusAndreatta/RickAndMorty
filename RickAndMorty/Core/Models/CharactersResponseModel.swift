//
//  CharactersResponseModel.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import Foundation

struct CharactersResponseModel: Codable {
    let info: PageInfoModel
    let results: [CharacterModel]
}
