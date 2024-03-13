import SwiftUI
import SwiftData

struct ContentView: View {
    let container: ModelContainer
    
    var body: some View {
        TabView {
            TopAlbumsViewFactory.make(container: container)
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
            
            SearchViewFactory.make(container: container)
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
            
            FavouriteTracksViewFactory.make(container: container)
                .tabItem {
                    Label(
                        title: {
                            Text("Favs")
                        },
                        icon: {
                            Image(systemName: "heart")
                        }
                    )
                }
        }
        .tint(Color.purple)
    }
}
