//
//  UpgradesView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/27/25.
//
import SwiftUI

struct UpgradesView: View {
    @EnvironmentObject var game: GameLogic
    
    var body: some View {
        HStack {
            Image("PokeCoin")
                .resizable()
                .scaledToFit()
                .frame(width: 55, height: 55)
            Text("\(game.coins) coins")
        }
        
        ScrollView {
            VStack(spacing: 12) {
                Text("Welcome to PokeMart!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                
                // Upgrade 1:
                UpgradesCard(
                    title: "Trainer Gloves",
                    subtitle: "+1 Coin Per Click (200 coins)",
                    action: {
                        game.buyGlovesUpgrade()
                    }
                )
                
                //Upgrade 2:
                UpgradesCard(
                    title: "Shiny Charm",
                    subtitle: "Increases shiny odds by 10% (500 coins)",
                    action: {
                        game.buyShinyBoostUpgrade()
                    }
                )
            }
        }
        .padding()
    }
}
