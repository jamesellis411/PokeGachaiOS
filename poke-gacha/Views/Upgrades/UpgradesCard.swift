//
//  UpgradesCard.swift
//  poke-gacha
//
//  Created by James Ellis on 11/27/25.
//
import SwiftUI

struct UpgradesCard: View {
    @EnvironmentObject var game: GameLogic

    let title: String
    let subtitle: String
    let action: () -> Bool

    @State private var errorMessage: String? = nil

    var body: some View {
        VStack(spacing: 6) {
            
            // The button itself
            Button {
                let success = action()
                if !success {
                    errorMessage = "Not enough coins!"
                } else {
                    errorMessage = nil
                }
            } label: {
                VStack(spacing: 6) {
                    Text(title).font(.headline)
                    Text(subtitle).font(.subheadline)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 4)
            }
            .buttonStyle(.plain)

            if let errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
}
