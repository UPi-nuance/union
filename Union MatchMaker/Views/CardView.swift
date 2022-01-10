//
//  CardView.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import SwiftUI

struct CardView: View {
    var card: UnionCard?
    var index: Int
    var isSelected: Bool
    var isHinted: Bool
    var onClicked: (Int) -> Void

    var backgroundColor: Color {
        if isSelected {
            return Color("SelectedCardBackground")
        } else if isHinted {
            return Color("HintedCardBackground")
        } else {
            return Color.clear
        }

    }

    var body: some View {
        if let card = self.card {
            Button(
                action: {
                    onClicked(index)
                },
                label: {
                    CardImage(imageName: card.imageName)
                }
            )
            .background(backgroundColor)
        } else {
            Image("card_empty")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct CardImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}
