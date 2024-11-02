//
//  ScrollHome.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 03/11/2024.
//

import SwiftUI

struct ScrollHome: View {
    @State private var allExpenses: [ExpenseModel] = []
    @State var activeCard: UUID?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Hello iJustine ")
                        .font(.largeTitle.bold())
                        .frame(height: 45)
                        .padding(.horizontal, 15)
                    
                    GeometryReader {
                        let rect = $0.frame(in: .scrollView)
                        let minY = rect.minY.rounded()
                        
                        // Card View
                        
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                ForEach(cards) { card in
                                    ZStack {
                                        if minY == 75.0 {
                                            // Not Scrolled
                                            // Showing All Cards
                                            CardView(card)
                                        } else {
                                            // Scrolled
                                            // Showing Only Selected Card
                                            if activeCard == card.id {
                                                CardView(card)
                                            } else {
                                                Rectangle()
                                                    .fill(.clear)
                                            }
                                        }
                                    }
                                    .containerRelativeFrame(.horizontal)
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .scrollTargetBehavior(.paging)
                        .scrollPosition(id: $activeCard)
                        .scrollClipDisabled()
                        .scrollIndicators(.hidden)
                        .scrollDisabled(minY != 75.0)
                    }
                    .frame(height: 125)
                }
                
                LazyVStack(spacing: 15) {
                    Menu {
                        
                    } label: {
                        HStack(spacing: 4) {
                            Text("Filter By")
                            Image(systemName: "chevron.down")
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    ForEach(allExpenses) { expenses in
                        ExpenseCardView(expenses)
                            .containerRelativeFrame(.horizontal)
                    }
                }
                .padding(15)
                .mask({
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(.white)
                    
                    // Limiting BackGround Scroll below the header
                        .visualEffect { content, proxy in
                            content
                                .offset(y: backgroundLimitOffset(proxy))
                        }
                })
                .background {
                    GeometryReader {
                        let rect = $0.frame(in: .scrollView)
                        let minY = min(rect.minY - 125, 0)
                        let progress = max(min(-minY / 25, 1), 0)
                        
                        RoundedRectangle(cornerRadius: 30 * progress, style: .continuous)
                            .fill(.white)
                        
                        // Limiting BackGround Scroll below the header
                            .visualEffect { content, proxy in
                                content
                                    .offset(y: backgroundLimitOffset(proxy))
                            }
                    }
                }
            }
            .padding(.vertical, 15)
        }
        .scrollTargetBehavior(CustomScrollTargetBehavior())
        .onAppear {
            if activeCard == nil{
                activeCard = cards.first?.id
            }
        }
        .onChange(of: activeCard) { oldValue, newValue in
            withAnimation(.snappy) {
                allExpenses = expenses.shuffled()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    // MARK: Background Limit Offset
    func backgroundLimitOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY
        return minY < 100 ? -minY + 100 : 0
    }
    
    // MARK: Card View
    @ViewBuilder
    func CardView(_ card: CardModel) -> some View {
        GeometryReader {
            let rect = $0.frame(in: .scrollView(axis: .vertical))
            let minY = rect.minY
            let topValue: CGFloat = 75.0
            
            let offset = min(minY - topValue, 0)
            let progress = max(min(-offset / topValue, 1), 0)
            let scale: CGFloat = 1.0 + progress
            
            ZStack {
                Rectangle()
                    .fill(card.bgColor)
                    .overlay(alignment: .leading) {
                        Circle()
                            .fill(card.bgColor)
                            .overlay {
                                Circle()
                                    .fill(Color.white.opacity(0.2))
                            }
                            .scaleEffect(2, anchor: .topLeading)
                            .offset(x: -50, y: -40)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    .scaleEffect(scale, anchor: .bottom)
                
                VStack(alignment: .leading, spacing: 4) {
                    Spacer(minLength: 0)
                    Text("Current Balance \(progress)")
                        .font(.callout)
                    
                    Text(card.balance)
                        .font(.title.bold())
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(15)
                .offset(y: progress * -25)
            }
            // stopping card
            .offset(y: -offset)
            // Moving till top Value
            .offset(y: progress * -topValue)
            
        }
        .padding(.horizontal, 15)
    }
    
    //MARK: EXpense Card View
    @ViewBuilder
    func ExpenseCardView(_ expense: ExpenseModel) -> some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.product)
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Text(expense.spendType)
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text(expense.amountSpent)
                .fontWeight(.bold)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 6)
    }
}

#Preview {
    ScrollHome()
}


//MARK: Custom Scroll target Behaviour
// AKA scrollWillEndDragging in UIKIt
struct CustomScrollTargetBehavior: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < 75 {
            target.rect = .zero
        }
    }
}
