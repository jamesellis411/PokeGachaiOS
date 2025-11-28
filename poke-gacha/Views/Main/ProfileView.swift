//
//  ProfileView.swift
//  poke-gacha
//
//  Created by James Ellis on 11/28/25.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var game: GameLogic
    @State private var showResetConfirm = false
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text("Trainer Profile")
                .font(.largeTitle)
                .bold()
                        
            Divider()
                .padding(.vertical)
            
            Button(role: .destructive) {
                showResetConfirm = true
            } label: {
                Text("Reset Account")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.15))
                    .foregroundColor(.red)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding()
        .alert("Reset Account?", isPresented: $showResetConfirm) {
            Button("Delete All Data", role: .destructive) {
                game.resetSave()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will erase all coins, upgrades, and caught Pokémon. This cannot be undone.")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(GameLogic())
}
