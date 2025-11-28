//
//  SaveData.swift
//  poke-gacha
//
//  Created by James Ellis on 11/28/25.
//
import Foundation

struct SaveData: Codable {
    let coins: Int
    let coinsPerTap: Int
    let shinyOddsBoost: Double
    let collection: [OwnedPokemon]
}
