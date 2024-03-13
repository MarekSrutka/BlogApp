//
//  Home.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import SwiftUI

struct Home: View {
    @StateObject var blogData = BlogViewModel()
    @Environment(\.colorScheme) var scheme
    var body: some View {
        VStack {
            if let posts = blogData.posts {
                if posts.isEmpty {
                    (
                        Text(Image(systemName: "rectangle.and.pencil.and.ellipsis"))
                        +
                        Text("Start Writting Blog")
                    )
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                } else {
                    List(posts) { post in
                        CardView(post: post)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    blogData.deletePost(post: post)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                    }
                    .listStyle(.insetGrouped)
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle("My Blog")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            Button(action: {
                blogData.createPost.toggle()
            }, label: {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundStyle(scheme == .dark ? Color.black : Color.white)
                    .padding()
                    .background(.primary, in: Circle())
            })
            .padding()
            .foregroundStyle(.primary)
            ,alignment: .bottomTrailing
        )
        .task {
            await blogData.fetchPosts()
        }
        .fullScreenCover(isPresented: $blogData.createPost, content: {
            CreatePost()
                .overlay(
                    ZStack {
                        Color.primary.opacity(0.25)
                            .ignoresSafeArea()
                        
                        ProgressView()
                            .frame(width: 80, height: 80)
                            .background(scheme == .dark ? .black : .white, in: RoundedRectangle(cornerRadius: 15))
                    }
                    .opacity(blogData.isWriting ? 1 : 0)
                )
                .environmentObject(blogData)
        })
        .alert(blogData.alertMessage, isPresented: $blogData.showAlert) {}
    }
}

#Preview {
    ContentView()
}
