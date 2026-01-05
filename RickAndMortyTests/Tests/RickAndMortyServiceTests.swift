//
//  RickAndMortyServiceTests.swift
//  RickAndMortyTests
//
//  Created by Mateus Andreatta on 1/5/26.
//
import XCTest
import Foundation

@testable import RickAndMorty

@MainActor
final class RickAndMortyServiceTests: XCTestCase {
    
    // MARK: - Character List
    
    func test_fetchCharacterList_callsSessionWithExpectedURL_andReturnsFailureWhenDecodingFails() async {
        // Arrange
        let expectedURL = RickAndMortyEndpoint.characterList(page: 2, name: "rick", filter: "alive").url
        let mockData = Data("invalid json".utf8)
        let mockResponse = HTTPURLResponse(url: expectedURL!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mock = MockSession(result: .success((mockData, mockResponse)))
        let service = RickAndMortyService(session: mock)
        
        // Act
        let result = await service.fetchCharacterList(page: 2, name: "rick", filter: "alive")
        
        // Assert
        XCTAssertEqual(mock.lastURL, expectedURL)
        if case .success = result {
            XCTFail("Expected failure due to decoding, got success")
        }
    }
    
    func test_fetchCharacterList_returnsFailureOnNetworkError() async {
        // Arrange
        let expectedURL = RickAndMortyEndpoint.characterList(page: 1, name: "", filter: "").url
        let networkError = URLError(.notConnectedToInternet)
        let mock = MockSession(result: .failure(networkError))
        let service = RickAndMortyService(session: mock)
        
        // Act
        let result = await service.fetchCharacterList(page: 1, name: "", filter: "")
        
        // Assert
        XCTAssertEqual(mock.lastURL, expectedURL)
        if case .success = result {
            XCTFail("Expected failure due to network error, got success")
        }
    }
    
    func test_fetchCharacterList_returnsSuccessOnValidJSON() async {
        // Arrange
        let expectedURL = RickAndMortyEndpoint.characterList(page: 1, name: "", filter: "").url
        let mockData = Data.characterListJSON()
        let mockResponse = HTTPURLResponse(url: expectedURL!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mock = MockSession(result: .success((mockData, mockResponse)))
        let service = RickAndMortyService(session: mock)
        
        // Act
        let result = await service.fetchCharacterList(page: 1, name: "", filter: "")
        
        // Assert
        XCTAssertEqual(mock.lastURL, expectedURL)
        if case .failure(let err) = result {
            XCTFail("Expected success, got failure: \(err)")
        }
    }
    
    // MARK: - Character Details
    
    func test_fetchCharacterDetails_callsSessionWithExpectedURL_andReturnsFailureWhenDecodingFails() async {
        // Arrange
        let id = 42
        let expectedURL = RickAndMortyEndpoint.characterDetail(id: id).url
        let mockData = Data("invalid json".utf8)
        let mockResponse = HTTPURLResponse(url: expectedURL!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mock = MockSession(result: .success((mockData, mockResponse)))
        let service = RickAndMortyService(session: mock)
        
        // Act
        let result = await service.fetchCharacterDetails(id: id)
        
        // Assert
        XCTAssertEqual(mock.lastURL, expectedURL)
        if case .success = result {
            XCTFail("Expected failure due to decoding, got success")
        }
    }
    
    func test_fetchCharacterDetails_returnsFailureOnNetworkError() async {
        // Arrange
        let id = 7
        let expectedURL = RickAndMortyEndpoint.characterDetail(id: id).url
        let networkError = URLError(.timedOut)
        let mock = MockSession(result: .failure(networkError))
        let service = RickAndMortyService(session: mock)
        
        // Act
        let result = await service.fetchCharacterDetails(id: id)
        
        // Assert
        XCTAssertEqual(mock.lastURL, expectedURL)
        if case .success = result {
            XCTFail("Expected failure due to network error, got success")
        }
    }
    
    func test_fetchCharacterDetails_returnsSuccessOnValidJSON() async {
        // Arrange
        let id = 1
        let expectedURL = RickAndMortyEndpoint.characterDetail(id: id).url
        let mockData = Data.characterDetailJSON()
        let mockResponse = HTTPURLResponse(url: expectedURL!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mock = MockSession(result: .success((mockData, mockResponse)))
        let service = RickAndMortyService(session: mock)
        
        // Act
        let result = await service.fetchCharacterDetails(id: id)
        
        // Assert
        XCTAssertEqual(mock.lastURL, expectedURL)
        if case .failure(let err) = result {
            XCTFail("Expected success, got failure: \(err)")
        }
    }
}
