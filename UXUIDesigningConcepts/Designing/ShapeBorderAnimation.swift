//
//  ShapeBorderAnimation.swift
//  ContinueLearningUI
//
//  Created by Muhammad Zeeshan on 28/10/2024.
//

import SwiftUI

struct ShapeBorderAnimation: View {
    
    @State private var rotation: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 260, height: 340)
                
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: 130, height: 500)
                .foregroundStyle(LinearGradient(colors: [Color(.blue), Color(.magenta)], startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(lineWidth: 7)
                        .frame(width: 256, height: 336)
                }
            
            Text("Gradient Card")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
//        .onAppear {
//            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
//                rotation = 360
//            }
//        }
    }
}

#Preview {
    ShapeBorderAnimation()
}
