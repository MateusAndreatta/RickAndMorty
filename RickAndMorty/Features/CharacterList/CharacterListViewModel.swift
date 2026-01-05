//
//  CharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import Foundation
import Combine

@MainActor
final class CharacterListViewModel: ObservableObject {
    
    @Published var viewState: CharacterListViewState = .loading
    @Published var searchName: String = ""
    @Published var selectedFilter: Filter = .all
    
    private let service: RickAndMortyServiceProtocol
    private var characters: [CharacterModel] = []
    private var page = 1
    private var pageInfo: PageInfoModel? = nil
    private var isLoadingPage = false

    init(service: RickAndMortyServiceProtocol) {
        self.service = service
    }
    
    func loadCharacters() async {
        guard canLoadNextPage else { return }

        if page == 1 {
            viewState = .loading
        }
            
        let result = await service.fetchCharacterList(page: page, name: searchName, filter: selectedFilter.filterValue)
        switch result {
        case .success(let response):
            handleResponse(response)
        case .failure:
            viewState = .error
        }
    }
    
    private var canLoadNextPage: Bool {
        guard let pageInfo else {
            return true
        }

        return page <= pageInfo.pages
    }
    
    private func handleResponse(_ response: CharactersResponseModel) {
        pageInfo = response.info
        if page > 1 {
            characters.append(contentsOf: response.results)
        } else {
            characters = response.results
        }
        viewState = .data(characters)
        page += 1
    }
}
