import SwiftUI

struct KappaView: View {
    var body: some View {
        ZStack {
            
            TitleView1()
            
            
            
            
            
            
            CardView1()
        }
    }
}

struct KappaView_Previews: PreviewProvider {
    static var previews: some View {
        KappaView()
    }
}

struct CardView1: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Hello, World!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
    }
}


struct TitleView1: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}
