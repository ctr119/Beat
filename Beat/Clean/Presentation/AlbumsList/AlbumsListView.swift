import SwiftUI

struct AlbumsListView: View {
    private enum DisplayMode: String, CaseIterable {
        case gallery = "square.grid.2x2.fill"
        case list = "rectangle.grid.1x2.fill"
    }
    
    @Binding var albums: [Album]
    @State private var displayMode: DisplayMode = .gallery
    @State private var router: AlbumsListRouter = .init()
    
    private let screenTitle: String
    
    init(
        screenTitle: String,
        albums: Binding<[Album]>
    ) {
        self.screenTitle = screenTitle
        self._albums = albums
        
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
            ScrollView {
                LazyVGrid(
                    columns: columns, spacing: 16
                ) {
                    ForEach(albums, id: \.id) { album in
                        row(for: album)
                            .onTapGesture {
                                print(album.id)
                                router
                                    .navigationPath
                                    .navigate(to: .albumDetails(id: album.id))
                            }
                    }
                }
                .padding(displayMode == .gallery ? 16 : 0)
            }
            .navigationTitle(screenTitle)
            .navigationDestination(for: AlbumsListRouter.Destination.self) { destination in
                router.view(for: destination)
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
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: displayMode == .gallery ? 2 : 1)
    }
    
    @ViewBuilder
    private func row(for album: Album) -> some View {
        if displayMode == .gallery {
            AlbumListGalleryRow(album: album)
        } else {
            AlbumListRow(album: album)
        }
    }
}

#if DEBUG
#Preview {
    @State var previewAlbums: [Album] = [
        .previewEminemMock,
        .previewSoadMock,
        .previewLinkinParkMock
    ]
    
    return AlbumsListView(
        screenTitle: "My List",
        albums: $previewAlbums
    )
}
#endif
