//
//  CharacterListViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Mateus Andreatta on 1/5/26.
//

import XCTest
import Foundation
@testable import RickAndMorty

@MainActor
final class CharacterListViewModelTests: XCTestCase {

    // MARK: - loadCharacters

    func test_loadCharacters_success_setsDataState() async {
        // Arrange
        let service = MockRickAndMortyService()
        service.fetchCharacterListResult = .success(.fixture())

        let sut = CharacterListViewModel(service: service)

        // Act
        await sut.loadCharacters()

        // Assert
        XCTAssertEqual(service.fetchCharacterListCallCount, 1)

        guard case .data(let characters) = sut.viewState else {
            return XCTFail("Expected .data state")
        }

        XCTAssertEqual(characters.count, 1)
        XCTAssertEqual(characters.first?.name, "Rick Sanchez")
    }

    func test_loadCharacters_failure_setsErrorState() async {
        // Arrange
        let service = MockRickAndMortyService()
        service.fetchCharacterListResult = .failure(.network(URLError(.timedOut)))

        let sut = CharacterListViewModel(service: service)

        // Act
        await sut.loadCharacters()

        // Assert
        XCTAssertEqual(service.fetchCharacterListCallCount, 1)
        guard case .error = sut.viewState else {
            return XCTFail("Expected .error state")
        }
    }

    // MARK: - Search debounce

    func test_searchName_triggersReload_afterDebounce() async {
        // Arrange
        let service = MockRickAndMortyService()
        service.fetchCharacterListResult = .success(.fixture())

        let sut = CharacterListViewModel(service: service)

        // Act
        sut.searchName = "Rick"

        // debounce = 400ms
        try? await Task.sleep(nanoseconds: 500_000_000)

        // Assert
        XCTAssertEqual(service.fetchCharacterListCallCount, 2)
        XCTAssertEqual(service.lastName, "Rick")
    }

    // MARK: - Filter change

    func test_selectedFilter_change_triggersReload() async {
        // Arrange
        let service = MockRickAndMortyService()
        service.fetchCharacterListResult = .success(.fixture())

        let sut = CharacterListViewModel(service: service)

        // Act
        sut.selectedFilter = .alive
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Assert
        XCTAssertEqual(service.fetchCharacterListCallCount, 2)
        XCTAssertEqual(service.lastFilter, Filter.alive.filterValue)
    }

    // MARK: - resetAndReload

    func test_resetAndReload_resetsState_andLoadsFirstPage() async {
        // Arrange
        let service = MockRickAndMortyService()
        service.fetchCharacterListResult = .success(.fixture())

        let sut = CharacterListViewModel(service: service)

        sut.searchName = "Morty"
        sut.selectedFilter = .dead

        // Act
        await sut.resetAndReload()

        // Assert
        XCTAssertEqual(service.fetchCharacterListCallCount, 1)
        XCTAssertEqual(service.lastPage, 1)
        XCTAssertEqual(service.lastName, "")
        XCTAssertEqual(service.lastFilter, Filter.all.filterValue)
    }
}
