//
//  SettingsView.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 09..
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: GameSettings

    var body: some View {
        Form {
            Section(header: Text("Options")) {
                Picker(selection: $settings.difficulty, label: Text("Difficulty")) {
                    Text("Easy").tag(GameDifficulty.easy)
                    Text("Hard").tag(GameDifficulty.hard)
                }
                Picker(selection: $settings.hints, label: Text("Hint delays")) {
                    Text("Instant").tag(GameHints.instant)
                    Text("Short").tag(GameHints.fast)
                    Text("Long").tag(GameHints.slow)
                    Text("No hints").tag(GameHints.never)
                }
                Button(
                    action: { settings.resetDefaults() },
                    label: { Text("Reset defaults") }
                )
            }
            Section(header: Text("Support")) {
                NavigationLink("Help", destination: HelpView())
                NavigationLink("About", destination: AboutView())
            }
        }
        .navigationTitle("Settings")
    }
}


struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            SettingsView()
        }
        .environmentObject(GameSettings())
    }
}
