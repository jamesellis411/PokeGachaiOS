//
//  PokemonService.swift
//  poke-gacha
//
//  Created by James Ellis on 11/18/25.
//
import Foundation

//struct Pokemon: Codable, Identifiable {
//let id: Int
//let name: String
//let sprites: Sprites
//let types: [PokemonType]?
//}

class PokemonService {
    static func fetchPokemon(idOrName: String) async throws -> Pokemon {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(idOrName.lowercased())") //fixed input error using lowercased to fit the GET request
        do {
            let (data, _) = try await URLSession.shared.data(from: url!) //request data from URL
            
            let response = try JSONDecoder().decode(Pokemon.self, from: data)
        
            return response
        } catch {
            //Handle and throw error
            print("Error with fetchPokemon: \(error.localizedDescription)")
            throw error
        }
    }
}

