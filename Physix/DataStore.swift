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
