//
//  Response+Fixture.swift
//  RickAndMortyTests
//
//  Created by Mateus Andreatta on 1/5/26.
//
import Foundation

extension Data {
    static func characterListJSON() -> Data {
        """
        {
          "info": {
            "count": 1,
            "pages": 1,
            "next": null,
            "prev": null
          },
          "results": [
            {
              "id": 1,
              "name": "Rick Sanchez",
              "status": "Alive",
              "species": "Human",
              "type": "",
              "gender": "Male",
              "origin": {
                "name": "Earth (C-137)",
                "url": "https://rickandmortyapi.com/api/location/1"
              },
              "location": {
                "name": "Citadel of Ricks",
                "url": "https://rickandmortyapi.com/api/location/3"
              },
              "image": "https://example.com/rick.png",
              "episode": [
                "https://rickandmortyapi.com/api/episode/1"
              ],
              "url": "https://rickandmortyapi.com/api/character/1"
            }
          ]
        }
        """.data(using: .utf8)!
    }

    static func characterDetailJSON() -> Data {
        """
        {
          "id": 1,
          "name": "Rick Sanchez",
          "status": "Alive",
          "species": "Human",
          "type": "",
          "gender": "Male",
          "origin": {
            "name": "Earth (C-137)",
            "url": "https://rickandmortyapi.com/api/location/1"
          },
          "location": {
            "name": "Citadel of Ricks",
            "url": "https://rickandmortyapi.com/api/location/3"
          },
          "image": "https://example.com/rick.png",
          "episode": [
            "https://rickandmortyapi.com/api/episode/1"
          ],
          "url": "https://rickandmortyapi.com/api/character/1"
        }
        """.data(using: .utf8)!
    }
}
