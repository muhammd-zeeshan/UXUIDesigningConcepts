//
//  MainView1.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 02/11/2024.
//

import SwiftUI

struct MainView1: View {
    @Binding var showShareView: Bool
    @State var copyLink = false
    var link1 = "https://www.apple.com"
    var link2 = "https://www.google.com"
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Image(systemName: "arrow.left").font(.title2)
                    .padding(10)
                    .background(.gray.opacity(0.15), in: Circle())
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .tint(.black)
            Spacer()
            
            Group {
                Text("Invite your friends\nto discover the app").bold().font(.largeTitle)
                Text("Your movements stay yours alone. Opt to share with family, gaining insight into lives as well-sharing is optional")
                    .frame(width: 300)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            SharingView()
                .frame(height: 300)
            
            HStack(spacing: 20) {
                Button {
                    UIPasteboard.general.string = link1
                    withAnimation {
                        copyLink.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                        withAnimation {
                            copyLink = false
                        }
                    }
                } label: {
                    VStack {
                        Image(systemName: "doc.on.doc").font(.title)
                        Text("Copy link")
                            .font(.system(size: 20, design: .serif))
                    }
                    .frame(width: 140, height: 120)
                    .background(.black.opacity(0.1), in: .rect(cornerRadius: 10))
                }
                
                ShareLink(item: URL(string: link1) ?? URL(string: link2)!){
                    VStack {
                        Image(systemName: "square.and.arrow.up").font(.title)
                        Text("Share")
                            .font(.system(size: 20, design: .serif))
                    }
                    .frame(width: 140, height: 120)
                    .background(.black.opacity(0.1), in: .rect(cornerRadius: 10))
                }
            }
            .tint(.black)
            Spacer()
            
            Button {
                
            } label: {
                Text("May be later")
                    .font(.system(size: 25))
                    .opacity(0.5)
            }
            .tint(.primary)
        }
        .overlay(alignment: .bottom, content: {
            Text("Link copied :)")
                .font(.headline)
                .bold()
                .frame(width: 150, height: 50)
                .background(.white, in: .rect(cornerRadius: 30))
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                .offset(y: copyLink ? 0 : 100)
        })
        .padding(.horizontal, 30)
    }
}

#Preview {
    MainView1(showShareView: .constant(.random()))
}
