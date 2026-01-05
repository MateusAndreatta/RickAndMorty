//
//  CharacterDetailsViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Mateus Andreatta on 1/5/26.
//

import XCTest
import Foundation
@testable import RickAndMorty

@MainActor
final class CharacterDetailsViewModelTests: XCTestCase {

    func test_loadDetails_success_setsDataState() async {
        // Arrange
        let service = MockRickAndMortyService()
        let expectedCharacter = CharacterModel.mock(id: 123)
        service.fetchCharacterDetailsResult = .success(expectedCharacter)

        let sut = CharacterDetailsViewModel(id: 123, service: service)

        // Act
        await sut.loadDetails()

        // Assert
        XCTAssertEqual(service.fetchCharacterDetailsCallCount, 1)
        XCTAssertEqual(service.lastRequestedID, 123)

        guard case .data(let character) = sut.viewState else {
            return XCTFail("Expected .data state")
        }

        XCTAssertEqual(character.id, 123)
        XCTAssertEqual(character.name, "Rick Sanchez")
    }

    func test_loadDetails_failure_setsErrorState() async {
        // Arrange
        let service = MockRickAndMortyService()
        service.fetchCharacterDetailsResult = .failure(.network(URLError(.timedOut)))

        let sut = CharacterDetailsViewModel(id: 1, service: service)

        // Act
        await sut.loadDetails()

        // Assert
        XCTAssertEqual(service.fetchCharacterDetailsCallCount, 1)

        guard case .error = sut.viewState else {
            return XCTFail("Expected .error state")
        }
    }

    func test_retry_callsLoadDetailsAgain() async {
        // Arrange
        let service = MockRickAndMortyService()
        service.fetchCharacterDetailsResult = .success(.mock())

        let sut = CharacterDetailsViewModel(id: 1, service: service)

        // Act
        await sut.loadDetails()
        await sut.retry()

        // Assert
        XCTAssertEqual(service.fetchCharacterDetailsCallCount, 2)
    }
}
