//
//  TabBar.swift
//  newStart
//
//  Created by Orestis Vaggelis on 17/8/20.
//  Copyright © 2020 Orestis Vaggelis. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Home().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            CourseList().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Courses")
            }
//            kappa().tabItem {
//                Image(systemName: "play.circle.fill")
//                Text("kappa")
//            }
            
            
        }
       // .edgesIgnoringSafeArea(.top)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
