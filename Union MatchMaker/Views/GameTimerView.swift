//
//  GameTimer.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 08..
//

import SwiftUI

func formattedTime(start: Date, finish: Date) -> String {
    let elapsedTimeSeconds = Int(start.distance(to: finish))
    let minutes = elapsedTimeSeconds / 60
    let seconds = elapsedTimeSeconds % 60
    return String(format:"%02d:%02d", minutes, seconds)
}

struct GameTimerView: View {
    @Binding var startTime: Date
    @State var now = Date()

    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()

    var body: some View {
        Text("\(formattedTime(start: startTime, finish: now))")
            .onReceive(timer) {
                now = $0
            }
    }
}
