//
//  RickAndMortyServiceProtocol.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/5/26.
//

protocol RickAndMortyServiceProtocol {
    func fetchCharacterList(page: Int, name: String, filter: String) async -> Result<CharactersResponseModel, ApiError>
    func fetchCharacterDetails(id: Int) async -> Result<CharacterModel, ApiError>
}
