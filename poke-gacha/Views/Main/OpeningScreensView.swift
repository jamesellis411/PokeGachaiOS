//
//  OpeningScreensView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/28/25.
//
import SwiftUI

struct OpeningScreensView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            VStack (spacing: 30) {
                Text("Welcome To\nPokeGacha!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                                
                Image("Pokeball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                                
                Text("Click Anywhere to Continue)")
                    .foregroundColor(.gray)
                    .font(.title3)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.6)) {
                isShowing = false
            }
        }
    }
}

#Preview {
    OpeningScreensView(isShowing: .constant(true))
}
