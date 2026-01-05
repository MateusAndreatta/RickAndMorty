//
//  Character+Fixture.swift
//  RickAndMortyTests
//
//  Created by Mateus Andreatta on 1/5/26.
//

@testable import RickAndMorty

extension CharacterModel {
    static func mock(
        id: Int = 1,
        name: String = "Rick Sanchez"
    ) -> CharacterModel {
        CharacterModel(
            id: id,
            name: name,
            status: "Alive",
            species: "Human",
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            gender: "Male",
            origin: OriginModel(
                name: "Earth",
                url: "https://rickandmortyapi.com/api/location/1"
            ),
            episode: [
                "https://rickandmortyapi.com/api/episode/1"
            ]
        )
    }
}
