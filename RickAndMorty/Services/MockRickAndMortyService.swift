//
//  MockRickAndMortyService.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/5/26.
//
#if DEBUG
class MockRickAndMortyService: RickAndMortyServiceProtocol {
    func fetchCharacterList(page: Int, name: String, filter: String) async -> Result<CharactersResponseModel, ApiError> {
        let mockCharacters = [
            CharacterModel(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", gender: "Male", origin: .init(name: "Earth", url: ""), episode: []),
            CharacterModel(id: 2, name: "Morty Smith", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", gender: "Male", origin: .init(name: "Earth", url: ""), episode: [])
        ]
        let response = CharactersResponseModel(info: .init(count: 2, pages: 1), results: mockCharacters)
        return .success(response)
    }
    
    func fetchCharacterDetails(id: Int) async -> Result<CharacterModel, ApiError> {
        let mockCharacter = CharacterModel(id: 1, name: "Rick", status: "Alive", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", gender: "Male", origin: .init(name: "Earth", url: ""), episode: [])
        return .success(mockCharacter)
    }
}
#endif
