//
//  ContentView.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 31/10/2024.
//

import SwiftUI
import Network

struct ContentView: View {
    @State var isConnected: Bool = false
    @State var showNotification: Bool = false
    @State var wasDisConnected: Bool = false
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkMonitor")
    
    var body: some View {
        ZStack {
            if !isConnected {
                ConnectionLost
            } else {
                Text("Your View").bold()
                    .font(.largeTitle)
            }
            WifiNotiftow(isConnected: $isConnected)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: showNotification ? 0 : -200)
                .padding()
                .onAppear {
                    startMonitoring()
                }
        }
        .padding()
    }
    var ConnectionLost: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 100))
                .foregroundStyle(.secondary)
            Text("Internet Connection Lost")
                .font(.title)
            Text("Please check your connection or go to WiFi settings to reconnect.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            Button {
                openSettings()
            } label: {
                Text("Open Settings")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .tint(.blue)
            .buttonStyle(.bordered)
        }
        .frame(width: 300)
    }
    
    // MARK: Open System Settings Func
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                let currentStatus = path.status == .satisfied
                if self.isConnected != currentStatus {
                    if currentStatus {
                        if self.wasDisConnected {
                            self.showNotification = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    self.showNotification = false
                                }
                            }
                        }
                    } else {
                        self.showNotification = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                self.showNotification = false
                            }
                        }
                        self.wasDisConnected = true
                    }
                    self.isConnected = currentStatus
                }
            }
        }
        monitor.start(queue: queue)
    }
}

#Preview {
    ContentView()
}
