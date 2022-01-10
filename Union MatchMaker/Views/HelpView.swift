//
//  HelpView.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Group {
                    Text("How to play")
                        .font(.largeTitle)
                    Text("The player must select three cards from the board that form a ") +
                    Text("Unity").foregroundColor(Color.accentColor) +
                    Text(". To form a ") +
                    Text("Unity").foregroundColor(Color.accentColor) +
                    Text(", the three cards must, for each attribute separately, be three of a kind, or three different kinds.")
                    Text("Cards have four attributes:")
                        .padding(.top)
                }
                VStack(alignment: .leading) {
                    Text("⚬ The shape")
                    Text("⚬ The color")
                    Text("⚬ The pattern")
                    Text("⚬ The number of shapes")
                }
                .padding(.leading)
                Group {
                    Text("For example, the following three cards form a ") +
                    Text("Unity").foregroundColor(Color.accentColor) +
                    Text(", because they have all different shapes, all the same color, all the same pattern and all different shapes.")
                    HStack {
                        CardImage(imageName: "card_0000")
                        CardImage(imageName: "card_1001")
                        CardImage(imageName: "card_2002")
                    }
                }
                .padding(.top)
                Group {
                    Text("On the other hand, the following three cards do NOT form a ") +
                    Text("Unity").foregroundColor(Color.accentColor) +
                    Text(", because there are two green cards and one red card.")
                    HStack {
                        CardImage(imageName: "card_0000")
                        CardImage(imageName: "card_0001")
                        CardImage(imageName: "card_0102")
                    }
                }
                Group {
                    Text("Winning")
                        .font(.largeTitle)
                    Text("There are 81 cards in the deck and 12 are dealt on the board initially. When the player finds a ") +
                    Text("Unity").foregroundColor(Color.accentColor) +
                    Text(", those three cards are taken off the board and new cards are dealt in their place. The game goes on until the deck is empty and there are no more matches on the board.")
                }
                Group {
                    Text("Hints")
                        .font(.largeTitle)
                        .padding(.top)
                    Text("For any given two cards there is exactly one third card with which they form ") +
                    Text("Unity").foregroundColor(Color.accentColor) +
                    Text(".")
                    Text("Enabling instant hints in the settings is a good way to train yourself to find the missing third card.")
                        .padding(.top)
                    Text("Occasionally the 12 cards on the board will not have any matches between them. In this case, the game will automatically deal three more cards in a new row. The new row will stay until all the cards within are gone.")
                        .padding(.top)
                    Text("Don't forget to brush your teeth.")
                        .padding(.top)
                }
                .padding(.bottom)
            }
            .padding(.horizontal)
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
