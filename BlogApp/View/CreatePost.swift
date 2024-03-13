//
//  CreatePost.swift
//  BlogApp
//
//  Created by Marek Srutka on 13.03.2024.
//

import SwiftUI

struct CreatePost: View {
    @EnvironmentObject var blogData: BlogViewModel
    
    @State var postTitle = ""
    @State var authorName = ""
    @State var postContent: [PostContent] = []
    
    @FocusState var showKeyboard: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    VStack(alignment: .leading) {
                        TextField("Post Title", text: $postTitle)
                            .font(.title2)
                        
                        Divider()
                    }
                    
                    VStack(alignment: .leading, spacing: 11) {
                        Text("Author:")
                            .font(.caption.bold())
                        
                        TextField("iJustine", text: $authorName)
                        
                        Divider()
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 20)
                    
                    ForEach($postContent) { $cont in
                        
                        VStack {
                            if cont.type == .Image {
                                if cont.showImage && cont.value != "" {
                                    WebImage(url: cont.value)
                                        .onTapGesture {
                                            withAnimation {
                                                cont.showImage = false
                                            }
                                        }
                                } else {
                                    VStack{
                                        TextField("Image URL", text: $cont.value) {
                                            withAnimation {
                                                cont.showImage = true
                                            }
                                        }
                                        
                                        Divider()
                                    }
                                    .padding(.leading, 5)
                                }
                            } else {
                                TextView(text: $cont.value, height: $cont.height, fontSize: getFontSize(type: cont.type))
                                    .focused($showKeyboard)
                                    .frame(height: cont.height == 0 ? getFontSize(type: cont.type) * 2 : cont.height)
                                    .autocorrectionDisabled(true)
                                    .background (
                                        Text(cont.type.rawValue)
                                            .font(.system(size: getFontSize(type: cont.type)))
                                            .foregroundStyle(.gray)
                                            .opacity(cont.value == "" ? 0.7 : 0)
                                            .padding(.leading, 5)
                                        ,alignment: .leading
                                    )
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onEnded ({ value in
                            if value.translation.width < ( (UIWindow.current?.bounds.width)! / 2.5 ) && !cont.showDeleteAlert {
                                cont.showDeleteAlert = true
                            }
                        }))
                        .alert("Sure to delete this content?", isPresented: $cont.showDeleteAlert) {
                            Button("Delete", role: .destructive) {
                                if let index = postContent.firstIndex(where: { $0.id == cont.id }) {
                                    DispatchQueue.main.async {
                                        postContent.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                    
                    Menu {
                        ForEach(PostType.allCases, id: \.rawValue) { type in
                            Button(type.rawValue) {
                                withAnimation {
                                    postContent.append(PostContent(value: "", type: type))
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title)
                            .foregroundStyle(.primary)
                    }
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .navigationTitle(postTitle == "" ? "Post Title" : postTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if !showKeyboard {
                        Button("Cancel") {
                            blogData.createPost.toggle()
                        }
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    if showKeyboard {
                        Button("Done") {
                            showKeyboard.toggle()
                        }
                    } else {
                        Button("Post") {
                            blogData.writePost(content: postContent, author: authorName, title: postTitle)
                        }
                        .disabled(authorName == "" || postTitle == "")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
