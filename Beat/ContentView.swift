import SwiftUI

struct ContentView: View {
    let useCase = GetTopAlbumsUseCase(albumsRepository: AlbumsRepositoryImplementation(albumsDataSource: AlbumsDataSourceImplementation(apiClient: ApiClient())))
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Request") {
                Task {
                    let albums = await useCase()
                    for album in albums {
                        print(album)
                        print("\n")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
