//
//  GameView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/24/25.
//
import SwiftUI
import Foundation
import Combine

@MainActor // will keep things updated on the main UI, added to fix error "Publishing changes from background threads is not allowed..."
class GameLogic: ObservableObject {
    // @Published will rerun the body of any view that needs it, to keep things up to date
    @Published var coins: Int = 0
    @Published var collection: [OwnedPokemon] = []
    @Published var coinsPerTap: Int = 1 //start with +1 on click
    @Published var shinyOddsBoost: Double = 0.0 // percent increase
    
    private let saveKey = "GameSaveData"
    private var autosaveCancellable: AnyCancellable?
    
    let capsuleCost: Int = 100
    
    init() {
            load()

            // 🔥 Autosave whenever ANY published value changes
            autosaveCancellable = objectWillChange
                .sink { [weak self] _ in
                    self?.save()
                }
    }
    
    func addCoin() {
        coins += coinsPerTap //on button click
    }
    
    func buyCapsule() async -> OwnedPokemon? {
        guard coins >= capsuleCost else {
            print("Not enough coins!")
            return nil
        }
        
        coins -= capsuleCost // removes coins from user on successful purchase
        
        do {
            let randomID = Int.random(in: 1...151) // get a random pokedex entry for the first 151 pokemon
            let newPokemon = try await PokemonService.fetchPokemon(idOrName: "\(randomID)") // fetch from pokemon service using the random ID
            let isShiny = Double.random(in: 0...1) < shinyOddsBoost
            
            let owned = OwnedPokemon(pokemon: newPokemon, isShiny: isShiny)
            collection.append(owned)
            
            return owned
        } catch {
            print("Error fetching pokemon: \(error.localizedDescription)")
            coins += capsuleCost // in the event that an error occurs, the user should be refunded their coins
            return nil
        }
    }
    
    func buyGlovesUpgrade() -> Bool {
        guard coins >= 200 else { return false }
        coins -= 200
        coinsPerTap += 1
        return true
    }
    
    func buyShinyBoostUpgrade() -> Bool {
        guard coins >= 500 else { return false }
        coins -= 500
        shinyOddsBoost += 0.1
        return true
    }
    
    func save() {
        let save = SaveData(
            coins: coins,
            coinsPerTap: coinsPerTap,
            shinyOddsBoost: shinyOddsBoost,
            collection: collection
        )

        do {
            let encoded = try JSONEncoder().encode(save)
            UserDefaults.standard.set(encoded, forKey: saveKey)
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: saveKey) else { return }
        do {
            let decoded = try JSONDecoder().decode(SaveData.self, from: data)
            self.coins = decoded.coins
            self.coinsPerTap = decoded.coinsPerTap
            self.shinyOddsBoost = decoded.shinyOddsBoost
            self.collection = decoded.collection
        } catch {
            print("Error loading data: \(error.localizedDescription)")
        }
    }
    
    func resetSave() {
        coins = 0
        coinsPerTap = 1
        shinyOddsBoost = 0.0
        collection = []

        UserDefaults.standard.removeObject(forKey: saveKey)
    }

}
