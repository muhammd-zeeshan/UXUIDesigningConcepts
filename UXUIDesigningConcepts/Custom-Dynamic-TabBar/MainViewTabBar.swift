//
//  MainViewTabBar.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 04/12/2024.
//

import SwiftUI

struct TabModel: Identifiable {
    var id = UUID()
    var icon: String
    var title: String
}

struct MainViewTabBar: View {
    var tabs: [TabModel] = [
        .init(icon: "person.fill", title: "Accounts"),
        .init(icon: "house.fill", title: "Home"),
        .init(icon: "creditcard", title: "Payments"),
        .init(icon: "arrow.right.arrow.left", title: "Transfer")
    ]
    
    @State private var selectedTab = 0
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                // 0, view changes based on this
                redView()
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                //1
                BlueView()
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                // 2
                GreenView()
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                // 3
                PinkView()
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
                // 4
                MintView()
                    .containerRelativeFrame(.horizontal, count: 1, spacing: 0)
            }
            .offset(x: -geo.size.width * CGFloat(selectedTab))
        }
        .overlay(alignment: .bottom) {
            HStack(spacing: 14) {
                ForEach(tabs.indices, id: \.self) { ind in
                    HStack {
                        Image(systemName: tabs[ind].icon)
                            .font(.title)
                        if selectedTab == ind {
                            Text(tabs[ind].title).bold()
                                .transition(.scale(scale: 0, anchor: .trailing).combined(with: .opacity))
                        }
                    }
                    .foregroundStyle(selectedTab == ind ? .black : .secondary)
                    .font(.title2)
                    .frame(maxWidth: selectedTab == ind ? .infinity : 45)
                    .frame(height: 55)
                    .background(Color(.separator), in: .rect(cornerRadius: 12))
                    .clipped()
                    .onTapGesture {
                        withAnimation {
                            selectedTab = ind
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MainViewTabBar()
}


struct redView: View {
    var body: some View {
        ZStack{
            Color.red.ignoresSafeArea()
            Text("Red View").font(.largeTitle)
        }
    }
}
struct BlueView: View {
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
            Text("Blue View").font(.largeTitle)
        }
    }
}
struct GreenView: View {
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            Text("Green View").font(.largeTitle)
        }
    }
}
struct PinkView: View {
    var body: some View {
        ZStack{
            Color.pink.ignoresSafeArea()
            Text("Pink View").font(.largeTitle)
        }
    }
}
struct MintView: View {
    var body: some View {
        ZStack{
            Color.mint.ignoresSafeArea()
            Text("Mint View").font(.largeTitle)
        }
    }
}
