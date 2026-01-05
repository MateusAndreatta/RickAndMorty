//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import SwiftUI

struct CharacterDetailsView: View {
    @StateObject var viewModel: CharacterDetailsViewModel

    var body: some View {
        ScrollView {
            switch viewModel.viewState {
            case .loading:
                ProgressView()
                    .task { await viewModel.loadDetails() }
            case .error:
                ErrorView()
            case .data(let character):
                ContentView(for: character)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    func ErrorView() -> some View {
        ContentUnavailableView {
            Label("Could not load character", systemImage: "exclamationmark.triangle")
        } description: {
            Text("Try again later.")
        } actions: {
            Button("Retry") { Task { await viewModel.retry() } }
        }
    }
    
    @ViewBuilder
    func ContentView(for character: CharacterModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: character.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    ProgressView()
                        .frame(height: 200)
                }
            }

            Text(character.name)
                .font(.title)
                .bold()

            VStack(alignment: .leading, spacing: 4) {
                Text("Status")
                    .font(.headline)
                Text(character.status)
                    .font(.body)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Specie")
                    .font(.headline)
                Text(character.species)
                    .font(.body)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Gender")
                    .font(.headline)
                Text(character.gender)
                    .font(.body)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Origin")
                    .font(.headline)
                Text(character.origin.name)
                    .font(.body)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Episodes")
                    .font(.headline)
                Text("\(character.episode.count) appearances")
                    .font(.body)
            }
            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    let viewModel = CharacterDetailsViewModel(id: 1, service: MockRickAndMortyService())
    CharacterDetailsView(viewModel: viewModel)
}
