//
//  Models.swift
//  poke-gacha
//
//  Created by James Ellis on 11/16/25.
//

import Foundation

struct NamedAPIResource: Codable, Identifiable {
    let name: String
    let url: String
    var id: String {url}
}

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [PokemonType]?
}

struct Sprites: Codable {
    let front_default: String?
}

struct PokemonType: Codable {
    let slot: Int
    let type: NamedAPIResource
}
