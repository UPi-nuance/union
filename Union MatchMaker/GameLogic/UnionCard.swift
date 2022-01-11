//
//  UnionCard.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import Foundation


enum UnionShape: Int, CaseIterable {
    case circle, triangle, star
}

enum UnionColor: Int, CaseIterable {
    case green, red, blue
}

enum UnionFill: Int, CaseIterable {
    case solid, outline, wavy
}

enum UnionMultiples: Int, CaseIterable {
    case single, double, triple
}

class UnionCard: CustomStringConvertible {
    var shape: UnionShape
    var color: UnionColor
    var fill: UnionFill
    var multiples: UnionMultiples

    init(shape: UnionShape, color: UnionColor, fill: UnionFill, multiples: UnionMultiples) {
        self.shape = shape
        self.color = color
        self.fill = fill
        self.multiples = multiples
    }

    var description: String {
        return "\(shape) \(color) \(fill) card with \(multiples) glyphs"
    }

    var imageName: String {
        return "card_\(shape.rawValue)\(color.rawValue)\(fill.rawValue)\(multiples.rawValue)"
    }

}

func unionError(card1: UnionCard, card2: UnionCard, card3: UnionCard) -> String? {

    func isTraitCorrect<T: Equatable>(_ a: T, _ b: T, _ c: T) -> String? {
        if ((a == b) && (b == c)) {
            // all the same, good union trait
            return nil
        }
        if ((a != b) && (b != c) && (a != c)) {
            // all different, good union trait
            return nil
        }

        // Not a good union because the distribution of traits is 2 to 1
        if a == b {
            return "Not a good Union because two cards are \(a) and one card is \(c)"
        } else if a == c {
            return "Not a good Union because two cards are \(a) and one card is \(b)"
        } else {
            return "Not a good Union because two cards are \(b) and one card is \(a)"
        }
    }

    let error = isTraitCorrect(card1.shape, card2.shape, card3.shape)
        ?? isTraitCorrect(card1.color, card2.color, card3.color)
        ?? isTraitCorrect(card1.fill, card2.fill, card3.fill)
        ?? isTraitCorrect(card1.multiples, card2.multiples, card3.multiples)

    return error
}

func isUnion(card1: UnionCard, card2: UnionCard, card3: UnionCard) -> Bool {
    return unionError(card1: card1, card2: card2, card3: card3) == nil
}
