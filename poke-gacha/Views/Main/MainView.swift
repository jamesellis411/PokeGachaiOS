//
//  MainView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/24/25.
//
import SwiftUI

struct MainView: View {
    @EnvironmentObject var game: GameLogic
    @State private var lastPokemon: OwnedPokemon? = nil

    var body: some View {
        VStack {
            // Top Row
            HStack {
                NavigationLink {
                    ProfileView()
                        .environmentObject(game)
                } label: {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.black)
                }
                Spacer()

                HStack {
                    Image("PokeCoin")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)

                    Text("\(game.coins) coins")
                }
            }

            Spacer()

            // Clicker
            Button {
                game.addCoin()
                SoundManager.shared.playSound(named: "click")
            } label: {
                Image("Pokeball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }

            // Buy Capsule
            Button("Buy Capsule (100 Coins)") {
                Task {
                    if let pulled = await game.buyCapsule() {
                        lastPokemon = pulled
                    }
                }
            }
            .buttonStyle(.bordered)

            Spacer()

            // Bottom Row
            HStack {
                NavigationLink("Battle") {
                    BattlesView()
                }
                .buttonStyle(.bordered)

                Spacer()
                
                NavigationLink("Upgrades") {
                    UpgradesView()
                        .environmentObject(game)
                }
                .buttonStyle(.bordered)
                
                Spacer()

                NavigationLink("Pokedex") {
                    PokedexView()
                        .environmentObject(game)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 25)
        .sheet(item: $lastPokemon) { owned in
            OpeningAnimationView(owned: owned)
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
            .environmentObject(GameLogic())
    }
}
