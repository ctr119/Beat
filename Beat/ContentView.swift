import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TopAlbumsViewFactory.make()
                .tabItem {
                    Label(
                        title: {
                            Text("Top")
                        },
                        icon: {
                            Image(systemName: "star")
                        }
                    )
                }
            
            SearchViewFactory.make()
                .tabItem {
                    Label(
                        title: {
                            Text("Search")
                        },
                        icon: {
                            Image(systemName: "magnifyingglass")
                        }
                    )
                }
        }
        .tint(Color.purple)
    }
}

#if DEBUG
#Preview {
    ContentView()
}
#endif
