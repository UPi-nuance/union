//
//  ContentView.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameSettings: GameSettings

    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Text("❤️")
                    Text("Union card matching game")
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Text("❤️")
                        .padding(.bottom)

                    NavigationLink(
                        destination: GameBoardView(viewModel: GameBoardViewModel(gameSettings: gameSettings))
                    ) {
                        Text("Start game")
                    }
                        .padding(.bottom)

                    NavigationLink(
                        destination: HelpView()
                    ) {
                        Text("Help")
                    }
                }
                .navigationTitle("Welcome")
            }
            .tabItem {
                Image(systemName: "gamecontroller.fill")
                Text("Play")
            }

            NavigationView {
                SettingsView()
            }
            .tabItem {
                Image(systemName: "pencil.circle.fill")
                Text("Settings")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

