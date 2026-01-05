//
//  CharactersResponseModel+Fixture.swift
//  RickAndMortyTests
//
//  Created by Mateus Andreatta on 1/5/26.
//
@testable import RickAndMorty

extension CharactersResponseModel {
    static func fixture() -> CharactersResponseModel {
        CharactersResponseModel(
            info: PageInfoModel(count: 1, pages: 1),
            results: [
                CharacterModel(
                    id: 1,
                    name: "Rick Sanchez",
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
            ]
        )
    }
}
