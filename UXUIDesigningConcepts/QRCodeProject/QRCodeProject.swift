//
//  QRCodeProject.swift
//  UXUIDesigningConcepts
//
//  Created by Muhammad Zeeshan on 02/11/2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeProject: View {
    var text: String
    
    var body: some View {
        VStack {
            Text("QR Code")
                .font(.title2.bold())
                .foregroundStyle(.primary)
                .padding(.top)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(width: 250, height: 250)
                .overlay {
                    Image(uiImage: genarateQRCode(from: text))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                    
                }
                .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 10)
        }
    }
    func genarateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")
        
        guard let outputImage = filter.outputImage, let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return UIImage() }
        return UIImage(cgImage: cgImage)
    }
}

#Preview {
    QRCodeProject(text: "")
}
