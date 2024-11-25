//
//  CardView.swift
//  ContinueLearningUI
//
//  Created by Muhammad Zeeshan on 28/10/2024.
//

import SwiftUI

struct CardMode: Identifiable {
    var id = UUID()
    var cardID = UUID()
    var TColor: Color
    var BColor: Color
    var name: String
    var num: String
}

struct CardView: View {
    var data: CardMode
    var namespace: Namespace.ID
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("Credit")
                    .matchedGeometryEffect(id: data.cardID, in: namespace)
                
                Spacer()
                
                Text(data.name)
                    .matchedGeometryEffect(id: data.name, in: namespace)
                Text(data.num)
                    .matchedGeometryEffect(id: data.num, in: namespace)
            }
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(Color(.white))
            Spacer()
            
            Text("Visa")
                .font(.system(size: 45, weight: .heavy, design: .rounded))
                .foregroundStyle(Color(.white).opacity(0.5))
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(25)
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .background(LinearGradient(colors: [data.BColor, data.BColor], startPoint: .topLeading, endPoint: .bottomTrailing), in: .rect(cornerRadius: 25))
        .padding(.horizontal)
    }
}

#Preview {
    CardContentView()
}
