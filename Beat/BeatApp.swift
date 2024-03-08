import SwiftUI

@main
struct BeatApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            TopAlbumsViewFactory.make()
        }
    }
}
