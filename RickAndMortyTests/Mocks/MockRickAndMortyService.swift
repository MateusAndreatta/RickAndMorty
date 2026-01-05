//
//  MockRickAndMortyService.swift
//  RickAndMortyTests
//
//  Created by Mateus Andreatta on 1/5/26.
//
@testable import RickAndMorty

@MainActor
final class MockRickAndMortyService: RickAndMortyServiceProtocol {

    var fetchCharacterListResult: Result<CharactersResponseModel, ApiError>?
    var fetchCharacterListCallCount = 0
    var lastPage: Int?
    var lastName: String?
    var lastFilter: String?

    func fetchCharacterList(
        page: Int,
        name: String,
        filter: String
    ) async -> Result<CharactersResponseModel, ApiError> {

        fetchCharacterListCallCount += 1
        lastPage = page
        lastName = name
        lastFilter = filter

        return fetchCharacterListResult ?? .failure(.unknown)
    }
    
    var fetchCharacterDetailsResult: Result<CharacterModel, ApiError>?
    var fetchCharacterDetailsCallCount = 0
    var lastRequestedID: Int?

    func fetchCharacterDetails(id: Int) async -> Result<CharacterModel, ApiError> {
        fetchCharacterDetailsCallCount += 1
        lastRequestedID = id
        return fetchCharacterDetailsResult ?? .failure(.unknown)
    }
}
