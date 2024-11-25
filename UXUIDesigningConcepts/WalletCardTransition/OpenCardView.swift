//
//  OpenCardView.swift
//  ContinueLearningUI
//
//  Created by Muhammad Zeeshan on 28/10/2024.
//

import SwiftUI

struct OpenCardView: View {
    @Binding var close: Bool
    @State var show = false
    var data: CardMode
    var nameSpace: Namespace.ID
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea()
            VStack {
                CardView(data: data, namespace: nameSpace)
                    .matchedGeometryEffect(id: data.id, in: namespace)
                    .onTapGesture {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                            withAnimation(.spring(duration: 0.2)) {
                                close = false
                            }
                        }
                        
                        withAnimation(.spring(duration: 0.2)) {
                            show = false
                        }
                    }
                ExpenseView(show: $show)
                    .offset(y: show ? 0 : 400)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                withAnimation(.spring(duration: 0.2)) {
                    show = true
                }
            }
        }
        .onDisappear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                withAnimation(.spring(duration: 0.2)) {
                    show = true
                }
            }
        }
        .onChange(of: close) { oldValue, newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                if newValue {
                    withAnimation(.spring(duration: 0.2)) {
                        show = false
                    }
                }
            }
        }
    }
}

#Preview {
//    OpenCardView()
    CardContentView()
}
