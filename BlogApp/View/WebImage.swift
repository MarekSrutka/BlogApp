//
//  WebImage.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import SwiftUI

struct WebImage: View {
    var url: String
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (UIWindow.current?.bounds.width)! - 30, height: 250)
                    .clipShape(.rect(cornerRadius: 15))
            } else {
                if let _ = phase.error {
                    Text("Failed to load Image")
                } else {
                    ProgressView()
                }
            }
        }
        .frame(height: 250)
    }
}
