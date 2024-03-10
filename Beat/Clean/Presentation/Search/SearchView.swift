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
                switch viewModel.state {
                case .idle:
                    Spacer()
                    
                case .loading:
                    progressIndicator
                    
                case .failed(let error):
                    Text("\(error.localizedDescription)")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                case .loaded(let albums):
                    AlbumsListView(
                        albums: albums,
                        rowBuilder: { album in
                            AlbumListGalleryRow(album: album)
                        },
                        onItemTapped: { album in
                            router
                                .navigationPath
                                .navigate(to: .albumDetails(id: album.id))
                        }
                    )
                }
                
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
    
    @ViewBuilder
    private var progressIndicator: some View {
        ProgressView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(
                    colors: [
                        Color.gray.opacity(0.7),
                        Color.gray.opacity(0.5),
                        .clear
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .tint(Color.black)
            .controlSize(.large)
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
