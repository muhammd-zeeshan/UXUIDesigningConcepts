//
//  ExpenseModel.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 03/11/2024.
//

import Foundation

struct ExpenseModel: Identifiable {
    var id: UUID = UUID()
    var amountSpent: String
    var product: String
    var spendType: String
}

var expenses: [ExpenseModel] = [
    ExpenseModel(amountSpent: "$128", product: "Amazon Purchase", spendType: "Groceries"),
    ExpenseModel(amountSpent: "$10", product: "Youtube Premium", spendType: "Streaming"),
    ExpenseModel(amountSpent: "$18", product: "Dribble", spendType: "Groceries"),
    ExpenseModel(amountSpent: "$99", product: "Mgic-Keyboard", spendType: "Membership"),
    ExpenseModel(amountSpent: "$9", product: "Petreon", spendType: "Products"),
    ExpenseModel(amountSpent: "$100", product: "Instagram", spendType: "Membership"),
    ExpenseModel(amountSpent: "$15", product: "Netflix", spendType: "Add Publish"),
    ExpenseModel(amountSpent: "$340", product: "Photoshop", spendType: "Membership"),
    ExpenseModel(amountSpent: "$99", product: "Figma", spendType: "Pro Member"),
    ExpenseModel(amountSpent: "$89", product: "Magic-Mouse", spendType: "Produc"),
    ExpenseModel(amountSpent: "$120", product: "Mac Studio", spendType: "Product"),
    ExpenseModel(amountSpent: "$39", product: "Sketch Book", spendType: "Editing")
]
