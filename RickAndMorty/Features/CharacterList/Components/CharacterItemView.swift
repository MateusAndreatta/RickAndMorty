//
//  CharacterItemView.swift
//  RickAndMorty
//
//  Created by Mateus Andreatta on 1/4/26.
//

import SwiftUI

/***
 Image
 Name
 Status (Alive/Dead/Unknown)
 Species
 */

struct CharacterItemView: View {
    
    let character: CharacterModel
    
    var body: some View {
        
        VStack {
            AsyncImage(url: URL(string: character.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Text(phase.error?.localizedDescription ?? "")
                    Color.red.frame(height: 100)
                } else {
                    ProgressView()
                        .frame(height: 200)
                }
            }
            Text(character.name)
                .font(.headline)
            HStack {
                Text(character.status)
                Text("|")
                Text(character.species)
            }
        }
        .frame(maxWidth: .infinity)
        .border(.black)
        

    }
}

#Preview {
    CharacterItemView(character: .init(id: 1,
                                       name: "Rick And Morty",
                                       status: "Alive",
                                       species: "Human",
                                       image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                                       origin: .init(name: "", url: ""),
                                       episode: []))
}
