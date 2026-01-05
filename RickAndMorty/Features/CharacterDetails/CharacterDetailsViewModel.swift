//
//  CharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import Foundation
import Combine

enum CharacterDetailsViewState {
    case loading
    case data(CharacterModel)
    case error
}

@MainActor
final class CharacterDetailsViewModel: ObservableObject {
    @Published var viewState: CharacterDetailsViewState = .loading

    private let service: RickAndMortyServiceProtocol
    private let id: Int
    private var isLoading = false

    init(id: Int, service: RickAndMortyServiceProtocol) {
        self.id = id
        self.service = service
    }

    func loadDetails() async {
        guard !isLoading else { return }
        isLoading = true
        viewState = .loading

        let result = await service.fetchCharacterDetails(id: id)
        switch result {
        case .success(let model):
            viewState = .data(model)
        case .failure:
            viewState = .error
        }

        isLoading = false
    }

    func retry() async {
        await loadDetails()
    }
}
