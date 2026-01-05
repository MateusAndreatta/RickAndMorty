//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    
    let container = DependencyContainer(
        service: RickAndMortyService(session: URLSession.shared),
    )
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CharacterListView(viewModel: container.makeCharacterListViewModel(),
                                  container: container)
                    .navigationTitle("Rick And Morty")
            }
        }
    }
}
