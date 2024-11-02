//
//  CardModel.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 03/11/2024.
//

import SwiftUI

struct CardModel: Identifiable {
    var id: UUID = .init()
    var bgColor: Color
    var balance: String
}

var cards: [CardModel] = [
    CardModel(bgColor: .red, balance: "$125,000"),
    CardModel(bgColor: .blue, balance: "$25,000"),
    CardModel(bgColor: .orange, balance: "$5,000"),
    CardModel(bgColor: .purple, balance: "$15,000"),
]
