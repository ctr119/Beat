import SwiftUI

struct SearchView: View {
    @State private var viewModel: SearchViewModel
    @State private var router: AlbumsListRouter
    
    init(viewModel: SearchViewModel, router: AlbumsListRouter) {
        self.viewModel = viewModel
        self.router = router
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
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
            .navigationTitle("Explore...")
            .navigationDestination(for: AlbumsListRouter.Destination.self) { destination in
                router.view(for: destination)
            }
        }
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
