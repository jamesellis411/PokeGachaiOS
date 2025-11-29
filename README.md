# PokeGacha
## Purpose
PokeGacha is a SwiftUI project designed to explore API networking, state management, data persistence, and animation. The game uses the PokéAPI to fetch live Pokémon data letting players build their own collection through a simple and satisfying game loop.
## API + Tools Used
- PokéAPI for live Pokémon data
- Built entirely with Swift and SwiftUI
  - AVFoundation for Sound Effects
  - UserDefaults for Autosave
## Check it Out Here

## Features
- Tap-based coun generation loop with a capsule purchase system that returns randomly selected Pokemon (including rare shiny variants)
- Player progression mechanics such as purchasable upgrades that modify click power and shiny odds
- Pokedex with searchable, sortable collections and reusable SwiftUI subviews that render Pokemon sprites
- Capsule-opening animations, sound effects, and a welcoming opening screen
- Autosave system that stores user data such as coints, upgrades, and collected Pokemon across sessions

## Obstacles & Solutions
- EnvironmentObject crashes:
  - Had issues with @EnvironmentObject not being passed into subviews properly, solved by inputting .environmentObject(game) at the top level.
- Background Thread Publishing Errors:
  - Learned to use @MainActor to ensure the GameLogic executed on the main thread while still having the network request working in the background.
- API Errors:
  - Sometimes PokeAPI sprites return nil, so I had to use safe optionals and images to fallback on to still display something to the user.
- User Data Disappearing:
  - The game now automatically saves progress into UserDefaults whenever @Published variables in GameLogic change
## Future Additions
- User vs. CPU Battles for various rewards (BattlesView)
- Generation selector for various capsules (Currently only 1-151 Pokemon)
- More upgrades
