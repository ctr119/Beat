import SwiftUI

struct SearchView: View {
    @State private var searchQuery = ""
    
    @State private var viewModel: SearchViewModel
    @State private var router: AlbumsListRouter
    
    init(viewModel: SearchViewModel, router: AlbumsListRouter) {
        self.viewModel = viewModel
        self.router = router
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                AlbumsListView(
                    albums: viewModel.albums,
                    rowBuilder: { album in
                        AlbumListGalleryRow(album: album)
                    },
                    onItemTapped: { album in
                        router
                            .navigationPath
                            .navigate(to: .albumDetails(id: album.id))
                    }
                )
                
                TextField("Search...", text: $searchQuery)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.3))
                    )
                    .padding()
                    .onSubmit {
                        Task {
                            await viewModel.performSearch(query: searchQuery)
                        }
                    }
            }
            .navigationTitle("Explore...")
            .navigationDestination(for: AlbumsListRouter.Destination.self) { destination in
                router.view(for: destination)
            }
        }
        .tint(Color.yellow)
    }
}

#if DEBUG
#Preview {
    SearchView(
        viewModel: .init(
            searchAlbumsUseCase: SearchAlbumsUseCasePreviewMock()
        ),
        router: .init()
    )
}
#endif
