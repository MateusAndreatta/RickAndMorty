//
//  RickAndMortyService.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//
import Foundation

protocol RickAndMortyServiceProtocol {
    func fetchCharacterList(page: Int, name: String, filter: String) async -> Result<CharactersResponseModel, ApiError>
    func fetchCharacterDetails(id: Int) async -> Result<CharacterModel, ApiError>
}

final class RickAndMortyService: RickAndMortyServiceProtocol {
    func fetchCharacterList(page: Int, name: String, filter: String) async -> Result<CharactersResponseModel, ApiError> {
        // TODO
        return .failure(.decodingError)
    }
    
    func fetchCharacterDetails(id: Int) async -> Result<CharacterModel, ApiError> {
        // TODO
        return .failure(.decodingError)
    }
    
}
