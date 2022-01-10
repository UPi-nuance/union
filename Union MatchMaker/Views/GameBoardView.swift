//
//  GameBoardView.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import SwiftUI

struct GameBoardView: View {
    @StateObject var viewModel: GameBoardViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        HStack(spacing: 0.0) {
            VStack(spacing: 10.0) {
                let boardInRows = viewModel.boardInRows
                let boardRowsIndexed = Array(zip(boardInRows, boardInRows.indices))

                ForEach(boardRowsIndexed, id: \.1, content: {
                    row in
                    HStack(spacing: 10.0) {
                        ForEach(row.0, id: \.1, content: {
                            (card, index) in
                            CardView(
                                card: card,
                                index: index,
                                isSelected: viewModel.selectedCards.contains(index),
                                isHinted: viewModel.hintedCards.contains(index)
                            ) {
                                viewModel.toggle(cardIndex: $0)
                            }
                        })
                    }
                })
            }
            .padding(.all)

            // Two dummy Text()s because alert modifiers need to be on separate branches of the UI
            // I tried EmtpyView() but then the alerts didn't show. ಠ_ಠ

            Text("")
                .alert(isPresented: $viewModel.showError) {
                    Alert(title: Text(viewModel.unionError ?? ""))
                }
            Text("")
                .alert(isPresented: $viewModel.showGameOver) {
                    Alert(
                        title: Text("Congratulations!"),
                        message: Text("You completed the game in \(viewModel.formattedGameTime)"),
                        dismissButton: .cancel(Text("OK")) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Text("\(viewModel.unionGame.numUnions) unions")
            }
            ToolbarItem(placement: .status) {
                if viewModel.unionGame.isGameOver {
                    Text(viewModel.formattedGameTime)
                } else {
                    GameTimerView(startTime: $viewModel.startTime)
                }
            }
            ToolbarItem(placement: .bottomBar) {
                Text("\(viewModel.unionGame.deck.count) cards")
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {

        GameBoardView(viewModel: GameBoardViewModel(gameSettings: GameSettings()))
    }
}
