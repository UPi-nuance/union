//
//  Union_MatchMakerApp.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import SwiftUI

@main
struct Union_MatchMakerApp: App {

    @StateObject var gameSettings = GameSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameSettings)
        }
    }
}
