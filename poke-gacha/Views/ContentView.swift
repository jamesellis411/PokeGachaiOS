//
//  ContentView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/16/25.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: GameLogic

    var body: some View {
        NavigationStack {
            MainView()
                
        }
        .environmentObject(game)
    }
}
