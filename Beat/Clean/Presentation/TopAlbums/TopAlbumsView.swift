import SwiftUI
import SwiftData

struct TopAlbumsView: View {
    private enum DisplayMode: String, CaseIterable {
        case gallery = "square.grid.2x2.fill"
        case list = "rectangle.grid.1x2.fill"
    }
    
    @State private var displayMode: DisplayMode = .gallery
    @State private var viewModel: ViewModel
    @State private var router: AlbumsListRouter
    
    init(viewModel: ViewModel, router: AlbumsListRouter) {
        self.viewModel = viewModel
        self.router = router
        
        UISegmentedControl.appearance()
            .selectedSegmentTintColor = .systemYellow
        
        UISegmentedControl.appearance()
            .setTitleTextAttributes(
                [.foregroundColor: UIColor.systemPurple],
                for: .selected
            )
        UISegmentedControl.appearance()
            .setTitleTextAttributes(
                [.foregroundColor: UIColor.gray],
                for: .normal
            )
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            AlbumsListView(
                albums: viewModel.albums,
                numberOfColumns: displayMode == .gallery ? 2 : 1,
                rowBuilder: { album in
                    if displayMode == .gallery {
                        AlbumListGalleryRow(album: album)
                    } else {
                        AlbumListRow(album: album)
                    }
                },
                onItemTapped: { album in
                    router
                        .navigationPath
                        .navigate(to: .albumDetails(id: album.id))
                }
            )
            .navigationTitle("Top Albums")
            .navigationDestination(for: AlbumsListRouter.Destination.self) { destination in
                router.view(for: destination)
            }
            .onAppear {
                Task {
                    await viewModel.loadAlbums()
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Picker("", selection: $displayMode) {
                        ForEach(DisplayMode.allCases, id: \.self) {
                            Image(systemName: $0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
        .tint(Color.yellow)
    }
}

#if DEBUG
#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TrackDTO.self, configurations: config)
    
    return TopAlbumsView(
        viewModel: .previewMock,
        router: .init(container: container)
    )
}
#endif
