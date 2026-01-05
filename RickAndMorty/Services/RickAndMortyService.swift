//
//  RickAndMortyService.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import Foundation

final class RickAndMortyService: RickAndMortyServiceProtocol {
    func fetchCharacterList(page: Int, name: String, filter: String) async -> Result<CharactersResponseModel, ApiError> {
        guard let url = RickAndMortyEndpoint.characterList(page: page, name: name, filter: filter).url else {
            return .failure(.unknown)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(CharactersResponseModel.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.network(error))
        }
    }
    
    func fetchCharacterDetails(id: Int) async -> Result<CharacterModel, ApiError> {
        guard let url = RickAndMortyEndpoint.characterDetail(id: id).url else {
            return .failure(.unknown)
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(CharacterModel.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(.network(error))
        }
    }
}
