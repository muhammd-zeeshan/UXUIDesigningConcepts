//
//  ExpenseView.swift
//  ContinueLearningUI
//
//  Created by Muhammad Zeeshan on 28/10/2024.
//

import SwiftUI

struct Expense: Identifiable {
    var id = UUID()
    var image: ImageResource
    var name: String
    var category: String
    var amount: String
    var date: String
}

struct ExpenseView: View {
    let expenses: [Expense] = [
        Expense(image: .user1, name: "Amazon", category: "Groceries", amount: "$128", date: "20/03/2024"),
        Expense(image: .user2, name: "Apple", category: "Apple Pay", amount: "$89", date: "20/03/2024"),
        Expense(image: .user3, name: "Youtube", category: "Streaming", amount: "$150", date: "20/03/2024"),
        Expense(image: .user4, name: "Dribble", category: "Membership", amount: "$200", date: "20/03/2024"),
        Expense(image: .user5, name: "PayPal", category: "Paypal", amount: "$128", date: "20/03/2024"),
        Expense(image: .user6, name: "Social", category: "Social Media", amount: "$350", date: "20/03/2024"),
        Expense(image: .user6, name: "Instagram", category: "Add Publish", amount: "$318", date: "20/03/2024"),
        Expense(image: .user7, name: "Skype", category: "Buy Number", amount: "$18", date: "20/03/2024")
    ]
    @Binding var show: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(expenses.indices, id: \.self) { index in
                    HStack(spacing: 16) {
                        Image(expenses[index].image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                        
                        VStack(alignment: .leading) {
                            Text(expenses[index].name)
                                .font(.headline)
                            Text(expenses[index].category)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(expenses[index].amount)
                                .font(.headline)
                            Text(expenses[index].date)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .foregroundStyle(.black)
                    .offset(y: show ? 0 : CGFloat(index * 100))
                    .opacity(show ? 1 : 0)
                    .animation(.spring(duration: Double(index) * 0.15), value: show)
                    .padding()
                }
            }
            .padding(10)
        }
        .scrollIndicators(.hidden)
        .background(.white, in: .rect(cornerRadius: 16))
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
        .padding(.horizontal, 20)
    }
}

#Preview {
    ExpenseView(show: .constant(true))
}
