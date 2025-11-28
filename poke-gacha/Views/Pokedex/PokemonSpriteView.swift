//
//  PokemonSpriteView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/25/25.
//

import SwiftUI

struct PokemonSpriteView: View {
    let owned: OwnedPokemon

    var body: some View {
        let spriteURL = owned.isShiny
            ? owned.pokemon.sprites.front_shiny
            : owned.pokemon.sprites.front_default

        if let urlString = spriteURL,
           let url = URL(string: urlString) {
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
        } else {
            Image(systemName: "questionmark")
        }
        
    }
    
}
