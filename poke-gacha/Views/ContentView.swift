//
//  ContentView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/16/25.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: GameLogic
    @State private var showOpening = true

    var body: some View {
        ZStack {
            NavigationStack {
                MainView()
                    .environmentObject(game)
            }
            .opacity(showOpening ? 0 : 1)
            
            if showOpening {
                OpeningScreensView(isShowing: $showOpening)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }

    }
}

#Preview {
    ContentView()
        .environmentObject(GameLogic())
}
