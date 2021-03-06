//
//  AboutView.swift
//  Union MatchMaker
//
//  Created by Ungar Peter on 2022. 01. 09..
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20.0) {
                Text("Unity MatchMaker")
                    .font(.title)
                    .foregroundColor(Color("AccentColor"))
                Text("By Peter Ungar")
                Text("Dedicated to my colleagues at Nuance")
                    .multilineTextAlignment(.center)
                HStack {
                    CardImage(imageName: "card_0000")
                    CardImage(imageName: "card_1200")
                    CardImage(imageName: "card_2100")
                }
            }
            .padding()
        .navigationTitle("About Unity")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView()
        }
    }
}
