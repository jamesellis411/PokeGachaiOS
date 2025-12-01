//
//  PokemonButtonStyle.swift
//  poke-gacha
//
//  Created by James Ellis on 12/1/25.
//
import SwiftUI

struct PokemonButtonStyle: ButtonStyle {
    var color: Color
    var canAfford: Bool = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .padding(.horizontal, 22)
            .padding(.vertical, 12)
            .background(
                    LinearGradient(
                    colors: [
                        color.opacity(0.85),
                        color.opacity(0.65)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(16)
            .shadow(
                color: canAfford ? color.opacity(0.7) : .clear,
                radius: canAfford ? 10 : 0
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}
