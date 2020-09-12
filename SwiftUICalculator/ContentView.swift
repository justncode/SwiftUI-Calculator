import SwiftUI

struct ContentView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @State private var result = "0"
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                if self.verticalSizeClass == .regular {
                    VStack(spacing: 0) {
                        ResultView(result: self.$result, geometry: geometry)
                        EntryView(result: self.$result)
                    }
                } else {
                    HStack(spacing: 0) {
                        ResultView(result: self.$result, geometry: geometry)
                        EntryView(result: self.$result)
                    }
                }
            }
            .preferredColorScheme(.dark)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}
