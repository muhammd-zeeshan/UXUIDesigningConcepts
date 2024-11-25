//
//  SwiftUIView.swift
//  ContinueLearningUI
//
//  Created by Muhammad Zeeshan on 28/10/2024.
//

import SwiftUI

struct CustomSwipe: View {
    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Custom Swipe")
        }
    }
}

#Preview {
    CustomSwipe()
}
