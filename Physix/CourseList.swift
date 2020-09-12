//
//  CourseList.swift
//  DesignCode
//
//  Created by Meng To on 2020-01-07.
//  Copyright © 2020 Meng To. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CourseList: View {
    @ObservedObject var store = CourseStore()
    @State var active = false
    @State var activeIndex = -1
    @State var activeView = CGSize.zero
    @State var isScrollable = false
    
    var body: some View {
        GeometryReader{ bounds in
        ZStack {
            Color.black.opacity(Double(self.activeView.height/500))
                .animation(.linear)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 30) {
                    Text("Courses")
                        .font(.largeTitle).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                        .blur(radius: self.active ? 20 : 0)
                    
                    ForEach(self.store.courses.indices, id: \.self) { index in
                        GeometryReader { geometry in
                            CourseView(
                                show: self.$store.courses[index].show,
                                course: self.store.courses[index],
                                active: self.$active,
                                index: index,
                                activeIndex: self.$activeIndex,
                                activeView: self.$activeView, bounds: bounds, isScrollable: self.$isScrollable
                            )
                                .offset(y: self.store.courses[index].show ? -geometry.frame(in: .global).minY : 0)
                                .opacity(self.activeIndex != index && self.active ? 0 : 1)
                                .scaleEffect(self.activeIndex != index && self.active ? 0.5 : 1)
                                .offset(x: self.activeIndex != index && self.active ? screen.width : 0)
                        }
                        .frame(height: 280)
                        .frame(maxWidth: self.store.courses[index].show ? .infinity : screen.width - 60)
                        .zIndex(self.store.courses[index].show ? 1 : 0)
                    }
                }
                .frame(width: screen.width)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            }
            .statusBar(hidden: self.active ? true : false)
            .animation(.linear)
            .disabled(self.active && !self.isScrollable ? true : false)
        }
      }
    }
}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList()
    }
}

struct CourseView: View {
    @Binding var show: Bool
    var course: Course
    @Binding var active: Bool
    var index: Int
    @Binding var activeIndex: Int
    @Binding var activeView: CGSize
    var bounds: GeometryProxy
    @Binding var isScrollable: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30.0) {
                Text("Introduction to Relativistic Mechanics")
                
                Text("About this course")
                    .font(.title).bold()
                
                Text("In this course we will seek to “understand Einstein,” especially focusing on the special theory of relativity that Albert Einstein, as a twenty-six year old patent clerk, introduced in his “miracle year” of 1905. Our goal will be to go behind the myth-making and beyond the popularized presentations of relativity in order to gain a deeper understanding of both Einstein the person and the concepts, predictions, and strange paradoxes of his theory. Some of the questions we will address include: How did Einstein come up with his ideas? What was the nature of his genius? What is the meaning of relativity? What’s “special” about the special theory of relativity? Why did the theory initially seem to be dead on arrival? What does it mean to say that time is the “fourth dimension”? Can time actually run more slowly for one person than another, and the size of things change depending on their velocity? Is time travel possible, and if so, how? Why can’t things travel faster than the speed of light? Is it possible to travel to the center of the galaxy and return in one lifetime? Is there any evidence that definitively confirms the theory, or is it mainly speculation? Why didn’t Einstein win the Nobel Prize for the theory of relativity?")
                
                
            }
            .animation(nil)
            .padding(30)
            .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? .infinity : 280, alignment: .top)
            .offset(y: show ? 460 : 0)
            .background(Color("background1"))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(show ? 1 : 0)
            
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 8.0) {
                        Text(course.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                        Text(course.subtitle)
                            .foregroundColor(Color.white.opacity(0.7))
                    }
                    Spacer()
                    ZStack {
                        Image(uiImage: course.logo)
                            .opacity(show ? 0 : 1)
                        
                        VStack {
                            Image(systemName: "xmark")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(width: 36, height: 36)
                        .background(Color.black)
                        .clipShape(Circle())
                        .opacity(show ? 1 : 0)
                        .offset(x: 2, y: -2)
                    }
                }
                Spacer()
                WebImage(url: course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 140, alignment: .top)
            }
            .padding(show ? 30 : 20)
            .padding(.top, show ? 30 : 0)
    //        .frame(width: show ? screen.width : screen.width - 60, height: show ? screen.height : 280)
                .frame(maxWidth: show ? .infinity : screen.width - 60, maxHeight: show ? 460 : 280)
                .background(Color(course.color))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
            .gesture(
                show ?
                DragGesture().onChanged { value in
                    guard value.translation.height < 300 else { return }
                    guard value.translation.height > 0 else { return }
                    
                    self.activeView = value.translation
                }
                .onEnded { value in
                    if self.activeView.height > 50 {
                        self.show = false
                        self.active = false
                        self.activeIndex = -1
                        self.isScrollable = false
                    }
                    self.activeView = .zero
                }
                : nil
            )
            .onTapGesture {
                self.show.toggle()
                self.active.toggle()
                if self.show {
                    self.activeIndex = self.index
                } else {
                    self.activeIndex = -1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.isScrollable = true
                }
            }
            
            if isScrollable {
                CourseDetail(course: course, show: $show, active: $active, activeIndex: $activeIndex, isScrollable: $isScrollable, bounds: bounds)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 30 , style: .continuous))
                    .animation(nil)
                    .transition(.identity)
            }
        }
        .frame(height: show ? screen.height : 280)
        .scaleEffect(1 - self.activeView.height / 1000)
        .rotation3DEffect(Angle(degrees: Double(self.activeView.height / 10)), axis: (x: 0, y: 10.0, z: 0))
        .hueRotation(Angle(degrees: Double(self.activeView.height)))
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
        .gesture(
            show ?
            DragGesture().onChanged { value in
                guard value.translation.height < 300 else { return }
                guard value.translation.height > 50 else { return }
                
                self.activeView = value.translation
            }
            .onEnded { value in
                if self.activeView.height > 50 {
                    self.show = false
                    self.active = false
                    self.activeIndex = -1
                    self.isScrollable = false
                }
                self.activeView = .zero
            }
            : nil
        )
        .disabled(active && !isScrollable ? true : false)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: URL
    var logo: UIImage
    var color: UIColor
    var show: Bool
}

var courseData = [
    Course(title: "Relativistic mechanics",
           subtitle: "18 Sections",
           image: URL(string: "https://dl.dropbox.com/s/pmggyp7j64nvvg8/Certificate%402x.png?dl=0")!,
           logo: #imageLiteral(resourceName: "phys1"),
           color: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
           show: false),
    Course(title: "Cosmology - Astrophysics",
           subtitle: "21 Sections",
           image: URL(string: "https://dl.dropbox.com/s/i08umta02pa09ns/Card3%402x.png?dl=0")!,
           logo: #imageLiteral(resourceName: "phys5"),
           color: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),
           show: false),
    Course(title: "Quantum mechanics",
           subtitle: "20 Sections",
           image: URL(string: "https://dl.dropbox.com/s/etdzsafqqeq0jjg/Card6%402x.png?dl=0")!,
           logo: #imageLiteral(resourceName: "phys8"),
           color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
           show: false)
]


