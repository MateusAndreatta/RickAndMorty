//
//  DependencyContainer.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/5/26.
//

import Foundation

final class DependencyContainer {
    let service: RickAndMortyServiceProtocol
    
    init(service: RickAndMortyServiceProtocol) {
        self.service = service
    }
    
    func makeCharacterListViewModel() -> CharacterListViewModel {
        CharacterListViewModel(service: service)
    }
    
    func makeCharacterDetailsViewModel(id: Int) -> CharacterDetailsViewModel {
        CharacterDetailsViewModel(id: id, service: service)
    }
}
