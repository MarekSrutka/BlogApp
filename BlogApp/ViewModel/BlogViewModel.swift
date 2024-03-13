//
//  BlogViewModel.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class BlogViewModel: ObservableObject {
    
    @Published var posts: [Post]?
    
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    @Published var createPost = false
    @Published var isWriting = false
    
    @MainActor func fetchPosts() async {
        do {
            let db = Firestore.firestore().collection("Blog")
            let posts = try await db.getDocuments()
            self.posts = posts.documents.compactMap({ post in
                return try? post.data(as: Post.self)
            })
        } catch {
            alertMessage = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    func deletePost(post: Post) {
        guard let _ = posts else { return }
        
        let index = posts?.firstIndex(where: { currentPost in
            return currentPost.id == post.id
        }) ?? 0
        
        Firestore.firestore().collection("Blog").document(post.id ?? "").delete()
        
        posts?.remove(at: index)
    }
    
    func writePost(content: [PostContent], author: String, title: String) {
        isWriting = true
        do {
            let post = Post(title: title, author: author, postContent: content, date: Timestamp(date: Date()))
            let _ = try Firestore.firestore().collection("Blog").document().setData(from: post)
            
            posts?.append(post)
            isWriting = false
            createPost = false
        } catch {
            isWriting = false
            print(error.localizedDescription)
        }
    }
}
