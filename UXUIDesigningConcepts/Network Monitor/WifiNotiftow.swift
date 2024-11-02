//
//  WifiNotiftow.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 01/11/2024.
//

import SwiftUI

struct WifiNotiftow: View {
    @Binding var isConnected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isConnected ? "wifi" : "wifi.slash")
                .foregroundColor(isConnected ? .green : .red)
                .font(.title2)
                .frame(width: 55, height: 50)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                .padding(.leading, 10)
            Text(isConnected ? "Internet Connect is Stored" : "Internet Connection is lost")
            Spacer()
        }
        .bold()
        .frame(maxWidth: .infinity, maxHeight: 70)
        .background(.ultraThickMaterial, in: .rect(cornerRadius: 20))
    }
}

#Preview {
    WifiNotiftow(isConnected: .constant(false))
}
