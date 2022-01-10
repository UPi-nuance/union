//
//  UnionGame.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import Foundation


class UnionGame: ObservableObject {
    @Published var deck: [UnionCard]
    @Published var board: [UnionCard?]
    @Published var isGameOver = false
    @Published var numUnions = 0
    @Published var hint = [-1, -1, -1]

    init(isEasy: Bool = false) {
        // Create the deck
        deck = []
        board = []

        let multiplesSet = isEasy ? [UnionMultiples.single] : UnionMultiples.allCases

        for shape in UnionShape.allCases {
            for color in UnionColor.allCases {
                for fill in UnionFill.allCases {
                    for multiples in multiplesSet {
                        let card: UnionCard = UnionCard(shape: shape, color: color, fill: fill, multiples: multiples)
                        deck.append(card)
                    }
                }
            }
        }

        // Create the board
        for _ in 0...14 {
            board.append(nil)
        }

        shuffleDeck()
        dealCards()
        // deck.removeAll()    // For quickly testing end of game
    }

    func shuffleDeck() {
        for i in 0 ..< deck.count {
            let j = Int.random(in: 0 ..< deck.count)
            deck.swapAt(i, j)
        }
    }

    func dealCards() {
        func getNextCard() -> UnionCard? {
            return deck.count > 0 ? deck.removeLast() : nil
        }

        for position in 0 ..< 12 {
            board[position] = board[position] ?? getNextCard()
        }

        countUnionsOnBoard()

        if (numUnions == 0) {
            // The last row is only dealt if there are no Unions in the first four rows
            for position in 12 ..< board.count {
                board[position] = board[position] ?? getNextCard()
            }
            countUnionsOnBoard()
        }
    }

    func getCardAt(position: Int) -> UnionCard? {
        return board[position]
    }

    func checkUnion(position1: Int, position2: Int, position3: Int) -> String? {
        let card1 = board[position1],
            card2 = board[position2],
            card3 = board[position3]
        if (card1 == nil || card2 == nil || card3 == nil) {
            return "You cannot create a Union with empty board positions.";
        }

        let error = unionError(card1: card1!, card2: card2!, card3: card3!)
        if (error != nil) {
            return error
        }

        board[position1] = nil
        board[position2] = nil
        board[position3] = nil
        dealCards()

        return nil
    }

    func countUnionsOnBoard() {
        numUnions = 0
        var unionsFound: [[Int]] = []

        for i in 0 ... board.count - 3 {
            let card1 = board[i]
            if card1 == nil { continue }

            for j in i + 1 ... board.count - 2 {
                let card2 = board[j]
                if card2 == nil { continue }

                for k in j + 1 ... board.count - 1 {
                    let card3 = board[k]
                    if card3 == nil { continue }

                    if isUnion(card1: card1!, card2: card2!, card3: card3!) {
                        numUnions += 1
                        unionsFound.append([i, j, k])
                    }
                }
            }
        }

        if (!unionsFound.isEmpty) {
            hint = unionsFound.randomElement()!
            hint.shuffle()
        } else {
            hint = [-1, -1, -1]
        }

        if numUnions == 0 && deck.count == 0 {
            isGameOver = true
        }
    }
}

