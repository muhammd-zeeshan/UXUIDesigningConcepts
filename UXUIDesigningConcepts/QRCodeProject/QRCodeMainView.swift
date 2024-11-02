//
//  QRCodeMainView.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 02/11/2024.
//

import SwiftUI

struct QRCodeMainView: View {
    @State private var text: String = ""
    @State private var isShowingQRCode: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Text("QR Code Generator")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                TextField("Enter Text for QR Code", text: $text)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                
                Button {
                    if !text.isEmpty{
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                            isShowingQRCode.toggle()
                        }
                    }
                    text = ""
                } label: {
                    Text("Generate")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(10)
                        .background(.green, in: .rect(cornerRadius: 10))
                }
                .foregroundStyle(.white)
                
                if isShowingQRCode {
                    QRCodeProject(text: text)
                        .transition(AnyTransition.asymmetric(insertion: .scale(scale: 0.01).combined(with: .opacity), removal: .scale))
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    QRCodeMainView()
}
