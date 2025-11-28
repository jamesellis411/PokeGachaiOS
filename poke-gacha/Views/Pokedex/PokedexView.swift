//
//  PokedexView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/25/25.
//

import SwiftUI

struct PokedexView: View {
    @EnvironmentObject var game: GameLogic
    
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "A-Z"
    
    private let sortOptions = ["A-Z", "Newest"]
    private var filteredPokemon: [OwnedPokemon] {
        var result = game.collection
        
        if !searchText.isEmpty {
            result = result.filter { owned in
                owned.pokemon.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        if selectedFilter == "A-Z" {
            result.sort{ $0.pokemon.name < $1.pokemon.name}
        } else if selectedFilter == "Newest" {
            result = result.reversed() // sort is generally old -> new, this flips it to new -> old
        }
        
        return result
    }
    
    var body: some View {
        VStack (spacing: 12) {
            
            //Search Bar
            TextField("Search Pokemon", text: $searchText)
            
            //Filtering
            Picker("Sort", selection: $selectedFilter) {
                ForEach(sortOptions, id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(.segmented)
            
            //Pokedex Grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))], spacing: 16){
                    ForEach(filteredPokemon) { owned in
                        PokemonSpriteView(owned: owned)
                    }
                }
            }
        }
        .padding()
        .navigationTitle(Text("Pokedex"))
    }
}

#Preview {
    NavigationStack {
        PokedexView()
            .environmentObject(GameLogic())
    }
}
