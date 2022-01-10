//
//  GameBoardViewModel.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import Foundation

class GameBoardViewModel: ObservableObject {
    @Published var unionGame: UnionGame
    @Published var selectedCards: Set<Int> = []
    @Published var hintedCards: Set<Int> = []
    @Published var unionError: String? = nil
    @Published var showGameOver: Bool = false
    var startTime = Date()

    // MARK: Hint-related members

    var timer = Timer()
    var lastUnionTime = Date()
    var hintLevel = 0
    var firstHintSec = 2.0
    var secondHintSec = 4.0

    // MARK: Initialization

    init(gameSettings: GameSettings) {
        unionGame = UnionGame(isEasy: gameSettings.difficulty == .easy)

        switch gameSettings.hints {
        case .instant:
            firstHintSec = 0.0
            secondHintSec = 0.0

        case .fast:
            firstHintSec = 8.0
            secondHintSec = 20.0

        case .slow:
            firstHintSec = 15.0
            secondHintSec = 40.0

        case .never:
            firstHintSec = Double.infinity
            secondHintSec = Double.infinity
        }

        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
           _ in self.onTimerTick()
        }
    }

    // MARK: Computed properties for the view

    var formattedGameTime: String {
        formattedTime(start: startTime, finish: unionGame.isGameOver ? lastUnionTime : Date())
    }

    var boardInRows: [[(card: UnionCard?, index: Int)]] {
        let board = unionGame.board
        var i = 0
        var result: [[(UnionCard?, Int)]] = []

        while i < board.count {
            var row: [(UnionCard?, Int)] = []
            for _ in 1...3 {
                if i < board.count {
                    row.append((card: board[i], index: i))
                }
                i += 1
            }
            if row.contains(where: {
                cardIndex in cardIndex.0 != nil
            }) {
                result.append(row)
            }
        }
        return result
    }

    var showError: Bool {
        get {
            unionError != nil
        }
        set(newValue) {
            if !newValue {
                unionError = nil
            }
        }
    }

    func toggle(cardIndex: Int) {
        if (selectedCards.contains(cardIndex)) {
            selectedCards.remove(cardIndex)
            return
        }

        selectedCards.insert(cardIndex)
        if selectedCards.count >= 3 {
            checkUnion()
            selectedCards.removeAll()
        }
    }

    // MARK: Private

    private func checkUnion() {
        let tags = selectedCards.map({ idx in idx })       // Is there a better way to turn a Set into an Array?
        unionError = unionGame.checkUnion(position1: tags[0], position2: tags[1], position3: tags[2])
        if unionError != nil {
            return
        }

        // The player has found a legitimate union.
        lastUnionTime = Date()
        hintLevel = 0
        hintedCards = []

        if unionGame.isGameOver {
            showGameOver = true
        }
    }

    private func onTimerTick() {
        let timeSinceSetSec = lastUnionTime.distance(to: Date())

        if timeSinceSetSec > secondHintSec && hintLevel < 2 {
            hintLevel = 2
            hintedCards = [unionGame.hint[0], unionGame.hint[1]]
        } else if timeSinceSetSec > firstHintSec && hintLevel < 1 {
            hintedCards = [unionGame.hint[0]]
        }
    }
}

