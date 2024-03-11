import SwiftUI
import SwiftData

struct ContentView: View {
    // TODO: Pass it to the Favourites tab factory when ready
    let container: ModelContainer
    
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
