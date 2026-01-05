//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import SwiftUI

enum CharacterListViewState {
    case data([CharacterModel])
    case loading
    case error
}



struct CharacterListView: View {
    
    let state: CharacterListViewState
    @State var searchName: String = ""
    @State var selectedFilter: Filter = .all
    
    var body: some View {
        switch state {
        case .data(let characters):
            ContentView(data: characters)
        case .error:
            ErrorView()
        case .loading:
            ProgressView()
        }
    }
    
    @ViewBuilder
    func ContentView(data: [CharacterModel]) -> some View {
        ScrollView {
            
            VStack {
                TextField(
                    "Search for character name..",
                    text: $searchName
                )
                .textFieldStyle(.roundedBorder)
                
                Picker("Filter", selection: $selectedFilter) {
                    ForEach(Filter.allCases) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
            }.padding()
            
            LazyVStack {
                ForEach(data, id: \.id) { character in
                    CharacterItemView(character: character)
                }
            }
        }
    }
    
    @ViewBuilder
    func ErrorView() ->  some View {
        ContentUnavailableView {
            Label("Something went wrong", systemImage: "exclamationmark.triangle")
        } description: {
            Text("We couldn’t load the data. Please try again.")
        } actions: {
            Button("Try Again") {
                print("retry")
            }
        }
    }
}

#Preview {
    let dummy: [CharacterModel] = [.init(id: 1,
                                         name: "Rick And Morty",
                                         status: "Alive",
                                         species: "Human",
                                         image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                                         origin: .init(name: "", url: ""),
                                         episode: [])]
    CharacterListView(state: .data(dummy))
}
