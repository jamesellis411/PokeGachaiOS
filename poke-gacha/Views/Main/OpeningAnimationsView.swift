//
//  OpeningAnimationsView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/27/25.
//
import SwiftUI

struct OpeningAnimationView: View {
    let owned: OwnedPokemon
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showPokeball = true
    @State private var showPokemon = false
    @State private var pokeballScale: CGFloat = 1.0
    @State private var pokemonScale: CGFloat = 0.5
    @State private var pokemonOpacity: Double = 0

    var body: some View {
        VStack(spacing: 24) {

            Text("Opening Capsule…")
                .font(.title2)
                .bold()

            ZStack {
                // Pokéball Animation
                if showPokeball {
                    Image("Pokeball")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .scaleEffect(pokeballScale)
                        .animation(.easeInOut(duration: 0.4), value: pokeballScale)
                        .transition(.scale)
                }

                // Pokémon Reveal Animation
                if showPokemon {
                    PokemonSpriteView(owned: owned)
                        .frame(width: 150, height: 150)
                        .scaleEffect(pokemonScale)
                        .opacity(pokemonOpacity)
                        .animation(.easeOut(duration: 0.4), value: pokemonOpacity)
                        .animation(.easeOut(duration: 0.4), value: pokemonScale)
                        .transition(.opacity.combined(with: .scale))
                }
            }

            if showPokemon {
                Text(owned.pokemon.name.capitalized)
                    .font(.title2)
                    .bold()
                    .transition(.opacity)
                    .animation(.easeIn.delay(0.2), value: showPokemon)
            }

            if owned.isShiny && showPokemon {
                Text("✨ SHINY ✨")
                    .font(.headline)
                    .foregroundColor(.yellow)
                    .transition(.opacity)
                    .animation(.easeIn.delay(0.4), value: showPokemon)
            }

            if showPokemon {
                Button("Close") {
                    withAnimation {
                        dismiss()
                    }
                }
                .buttonStyle(.bordered)
                .padding(.top, 15)
                .transition(.opacity)
            }
        }
        .padding()
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        // Pokeball "bounce"
        pokeballScale = 1.2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            pokeballScale = 0.8
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            pokeballScale = 1.0
        }

        // Reveal Pokémon (fade + scale)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation {
                showPokeball = false
            }
            withAnimation {
                showPokemon = true
            }
            pokemonOpacity = 1
            pokemonScale = 1.0
        }
    }
}

