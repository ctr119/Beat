import SwiftUI

struct ContentView: View {
    var body: some View {
        TopAlbumsViewFactory.make()
    }
}

#if DEBUG
#Preview {
    ContentView()
}
#endif
