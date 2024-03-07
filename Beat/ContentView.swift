import SwiftUI

struct ContentView: View {
    let repository = AlbumsRepositoryImplementation(albumsDataSource: AlbumsDataSourceImplementation(apiClient: ApiClient()))
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Request") {
                Task {
                    await repository.searchAlbum(with: "eminem")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
