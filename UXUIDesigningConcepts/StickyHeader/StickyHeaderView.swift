//
//  StickyHeaderView.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 31/10/2024.
//

import SwiftUI

struct StickyHeaderView: View {
    var body: some View {
        ScrollView {
            VStack {
                imageView()
                GridView()
            }
        }
        .ignoresSafeArea()
        .scrollIndicators(.hidden)
    }
}

#Preview {
    StickyHeaderView()
}

@ViewBuilder
func imageView() -> some View {
    GeometryReader { geo in
        let minY = geo.frame(in: .global).minY
        let isScrolling: Bool = minY > 0
        VStack {
            Image(.picP)
                .resizable()
                .scaledToFill()
                .frame(height: isScrolling ? 160 + minY : 160)
                .clipped()
                .offset(y: isScrolling ? -minY : 0)
                .blur(radius: isScrolling ? 0 + minY / 80 : 0)
                .scaleEffect(isScrolling ? 1 + minY / 2000 : 1)
                .overlay(alignment: .bottom) {
                    ZStack {
                        Image(.picP)
                            .resizable().scaledToFill()
                        Circle().stroke(lineWidth: 6)
                    }
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .offset(y: 60)
                    .offset(y: isScrolling ? -minY : 0)
                }
            
            Group {
                VStack(spacing: 6) {
                    Text("iJustine").font(.title.bold())
                    Text("I Started Learning About SwiftUI From Half Year ago 🥰. And I loved it very much")
                        .multilineTextAlignment(.center)
                        .font(.callout)
                        .foregroundStyle(.gray)
                        .frame(width: geo.size.width - 30)
                        .lineLimit(2)
                        .fixedSize()
                }
                .offset(y: isScrolling ? -minY : 0)
            }
            .padding(.vertical, 53)
        }
    }
    .frame(height: 340)
}


struct GridView: View {
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
            ForEach(0 ..< 25) { item in
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 180, height: 220)
                    .foregroundStyle(.ultraThinMaterial)
            }
        }
        .padding(.horizontal, 10)
    }
}
