//
//  CardView.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import SwiftUI
import Firebase

struct CardView: View {
    var post: Post
    
    var body: some View {
        NavigationLink {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Written By: \(post.author)")
                        .font(.callout)
                    
                    Text("Written By: \(post.date.dateValue().formatted(date: .numeric, time: .shortened))")
                        .font(.callout.bold())
                    
                    ForEach(post.postContent) { cont in
                        if cont.type == .Image {
                            WebImage(url: cont.value)
                        } else {
                            Text(cont.value)
                                .font(.system(size: getFontSize(type: cont.type)))
                                .lineSpacing(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(post.title)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                Text(post.title)
                    .fontWeight(.bold)
                Text("Written By: \(post.author)")
                    .foregroundStyle(.gray)
                    .font(.callout)
                
                Text("Written By: \(post.date.dateValue().formatted(date: .numeric, time: .shortened))")
                    .foregroundStyle(.gray)
                    .font(.callout.bold())
            }
        }
    }
}

#Preview {
    CardView(post: .init(id: "", title: "OneTwo", author: "Reznik", postContent: [], date: Timestamp(date: Date())))
}
