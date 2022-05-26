import SwiftUI
import SDWebImageSwiftUI

struct CourseDetail: View {
    var course: Course
    @Binding var show: Bool
    @Binding var active: Bool
    @Binding var activeIndex: Int
    @Binding var isScrollable: Bool
    var bounds: GeometryProxy
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
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
                            VStack {
                                Image(systemName: "xmark")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .frame(width: 36, height: 36)
                            .background(Color.black)
                            .clipShape(Circle())
                            .onTapGesture {
                                self.show = false
                                self.active = false
                                self.activeIndex = -1
                                self.isScrollable = false
                            }
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
                    .frame(maxWidth: show ? .infinity : bounds.size.width - 60, maxHeight: show ? 460 : 280)
                    .background(Color(course.color))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(course.color).opacity(0.3), radius: 20, x: 0, y: 20)
        VStack(alignment: .leading, spacing: 30.0) {
            Text("Introduction to Relativistic Mechanics")
            
            Text("About this course")
                .font(.title).bold()
            
            Text("In this course we will seek to “understand Einstein,” especially focusing on the special theory of relativity that Albert Einstein, as a twenty-six year old patent clerk, introduced in his “miracle year” of 1905. Our goal will be to go behind the myth-making and beyond the popularized presentations of relativity in order to gain a deeper understanding of both Einstein the person and the concepts, predictions, and strange paradoxes of his theory. Some of the questions we will address include: How did Einstein come up with his ideas? What was the nature of his genius? What is the meaning of relativity? What’s “special” about the special theory of relativity? Why did the theory initially seem to be dead on arrival? What does it mean to say that time is the “fourth dimension”? Can time actually run more slowly for one person than another, and the size of things change depending on their velocity? Is time travel possible, and if so, how? Why can’t things travel faster than the speed of light? Is it possible to travel to the center of the galaxy and return in one lifetime? Is there any evidence that definitively confirms the theory, or is it mainly speculation? Why didn’t Einstein win the Nobel Prize for the theory of relativity?")

            
        }
        .padding(30)
    }
}
.edgesIgnoringSafeArea(.all)
}
}

struct CourseDetail_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ bounds in
        CourseDetail(course: courseData[0], show:.constant(true), active: .constant(true), activeIndex: .constant(-1), isScrollable: .constant(true), bounds: bounds)
    }
}
}
