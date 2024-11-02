//
//  SharingView.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 02/11/2024.
//

import SwiftUI

struct SharingView: View {
    @State var show = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(.user1).resizable().scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(lineWidth: 3)
                        }
                        .offset(x: show ? 115 : 300, y: show ? -10 : -100)
                    
                    Image(.user2).resizable().scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(lineWidth: 3)
                        }
                        .offset(x: show ? -115 : -300, y: show ? -10 : -100)
                }
                
                HStack {
                    Image(.user1).resizable().scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(lineWidth: 3)
                        }
                        .offset(x: show ? 115 : 300, y: show ? 10 : 100)
                    
                    Image(.user2).resizable().scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(lineWidth: 3)
                        }
                        .offset(x: show ? -115 : -300, y: show ? 10 : 100)
                }
            }
            
            VStack {
                Image(.user5).resizable().scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(lineWidth: 3)
                    }
                    .offset(y: show ? -60 : -300)
                
                Image(.user6).resizable().scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(lineWidth: 3)
                    }
                    .offset(y: show ? 60 : 300)
            }
            
            Image(.user7).resizable().scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(lineWidth: 3)
                }
        }
        .rotationEffect(.degrees(show ? 0 : 100))
        .onAppear(){
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                show.toggle()
            }
        }
        .padding()
    }
}

#Preview {
    SharingView()
}
