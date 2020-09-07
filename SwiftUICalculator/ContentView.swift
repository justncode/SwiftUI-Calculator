import SwiftUI

struct ContentView: View {
    @State private var result = "0"
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ResultView(result: self.$result, geometry: geometry)
                EntryView(result: self.$result)
            }
            .preferredColorScheme(.dark)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}
