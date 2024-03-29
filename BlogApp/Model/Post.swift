//
//  Post.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct Post: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var author: String
    var postContent: [PostContent]
    var date: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case postContent
        case date
    }
}

struct PostContent: Identifiable, Codable {
    var id = UUID().uuidString
    var value: String
    var type: PostType
    
    var height: CGFloat = 0
    var showImage: Bool = false
    var showDeleteAlert: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case type = "key"
        case value
    }
}

enum PostType: String, CaseIterable, Codable {
    
    case Header = "Header"
    case SubHeading = "SubHeading"
    case Paragraph = "Paragraph"
    case Image = "Image"
}
