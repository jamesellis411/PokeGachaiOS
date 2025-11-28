//
//  poke_gachaApp.swift
//  poke-gacha
//
//  Created by James Ellis on 11/16/25.
//

import SwiftUI

@main
struct YourAppNameApp: App {
    @StateObject var game = GameLogic()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
