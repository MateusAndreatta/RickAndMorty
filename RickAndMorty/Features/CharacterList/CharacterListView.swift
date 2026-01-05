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
    @StateObject var viewModel: CharacterListViewModel
    @State private var isLoadingMore: Bool = false
    
    let container: DependencyContainer
    
    var body: some View {
        
        ScrollView {
            HeaderView()
            switch viewModel.viewState {
            case .data(let characters):
                if characters.isEmpty {
                    EmptyView()
                } else {
                    ContentView(data: characters)
                }
            case .error:
                ErrorView()
            case .loading:
                ProgressView()
                    .task {
                        await viewModel.loadCharacters()
                    }
            }
        }
    }
    
    @ViewBuilder
    func ContentView(data: [CharacterModel]) -> some View {
        LazyVStack {
            ForEach(data, id: \.id) { character in
                NavigationLink(destination: CharacterDetailsView(viewModel: container.makeCharacterDetailsViewModel(id: character.id))) {
                    CharacterItemView(character: character)
                }
                .buttonStyle(.plain)
                .onAppear {
                    if character.id == data.last?.id {
                        Task {
                            guard !isLoadingMore else { return }
                            isLoadingMore = true
                            await viewModel.loadCharacters()
                            isLoadingMore = false
                        }
                    }
                }
            }
        }.padding()
    }
    
    @ViewBuilder
    func ErrorView() ->  some View {
        ContentUnavailableView {
            Label("Something went wrong", systemImage: "exclamationmark.triangle")
        } description: {
            Text("We couldn’t load the data. Please try again.")
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.resetAndReload()
                }
            }
        }
    }
    
    @ViewBuilder
    func EmptyView() -> some View {
        ContentUnavailableView {
            Label("No Results Found", systemImage: "line.3.horizontal.decrease.circle")
        } description: {
            Text("Try changing or clearing the filters to see more characters.")
        } actions: {
            Button("Clear Filters") {
                Task {
                    await viewModel.resetAndReload()
                }
            }
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        VStack {
            TextField(
                "Search for character name..",
                text: $viewModel.searchName
            )
            .textFieldStyle(.roundedBorder)
            
            Picker("Filter", selection: $viewModel.selectedFilter) {
                ForEach(Filter.allCases) { filter in
                    Text(filter.rawValue).tag(filter)
                }
            }
            .pickerStyle(.segmented)
        }.padding()
    }
}

#Preview {
    let viewModel = CharacterListViewModel(service: MockRickAndMortyService())
    CharacterListView(viewModel: viewModel, container: DependencyContainer(service: MockRickAndMortyService()))
}
