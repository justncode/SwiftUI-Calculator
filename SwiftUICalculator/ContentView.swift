import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                ResultView(geometry: geometry)
                EntryView()
            }
            .preferredColorScheme(.dark)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}
