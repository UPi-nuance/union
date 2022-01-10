//
//  Settings.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 09..
//

import Foundation

enum GameDifficulty: String, CaseIterable, Identifiable  {
    case easy, hard

    var id: String { self.rawValue }
}

enum GameHints: String, CaseIterable, Identifiable {
    case instant, fast, slow, never

    var id: String { self.rawValue }
}

class GameSettings: ObservableObject {

    private enum Keys {
        static let difficulty = "settings.difficulty"
        static let hints = "settings.hints"
    }

    @Published var difficulty: GameDifficulty {
        didSet {
            UserDefaults.standard.set(difficulty.rawValue, forKey: Keys.difficulty)
        }
    }
    @Published var hints: GameHints {
        didSet {
            UserDefaults.standard.set(hints.rawValue, forKey: Keys.hints)
        }
    }

    init() {
        difficulty = .hard
        hints = .slow

        if let rawDifficulty = UserDefaults.standard.object(forKey: Keys.difficulty) as? String {
            difficulty = GameDifficulty(rawValue: rawDifficulty) ?? difficulty
        }
        if let rawHints = UserDefaults.standard.object(forKey: Keys.hints) as? String {
            hints = GameHints(rawValue: rawHints) ?? hints
        }
    }

    func resetDefaults() {
        difficulty = .hard
        hints = .slow
    }
}
