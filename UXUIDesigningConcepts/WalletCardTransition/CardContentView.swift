//
//  CardContentView.swift
//  ContinueLearningUI
//
//  Created by Muhammad Zeeshan on 28/10/2024.
//

import SwiftUI

struct CardContentView: View {
    var cards: [CardMode] = [
        CardMode(TColor: .white, BColor: .pink, name: "youssef", num: "*** *** *** 351"),
        CardMode(TColor: .white, BColor: .purple, name: "Rizwan", num: "*** *** *** 351"),
        CardMode(TColor: .white, BColor: .blue, name: "Usman", num: "*** *** *** 351")
    ]
    @State var show = false
    @Namespace var namespace
    @State var selectedCard: CardMode? = nil
    
    var body: some View {
        ZStack {
            if let selectedCard = selectedCard, show {
                OpenCardView(close: $show, data: selectedCard, nameSpace: namespace)
            } else {
                ScrollView {
                    VStack {
                        ForEach(cards) { item in
                            CardView(data: item, namespace: namespace)
                                .matchedGeometryEffect(id: item.id, in: namespace)
                                .onTapGesture {
                                    selectedCard = item
                                    withAnimation(.spring(duration: 0.2)) {
                                        show = true
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CardContentView()
}
