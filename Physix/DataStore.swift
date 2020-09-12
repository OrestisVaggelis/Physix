//
//  DataStore.swift
//  newStart
//
//  Created by Orestis Vaggelis on 29/8/20.
//  Copyright © 2020 Orestis Vaggelis. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var posts: [Post] = []
    
    init() {
        getPost()
    }
    
    func getPost() {
        Api().getPosts { (posts) in
            self.posts = posts
        }
    }
}
