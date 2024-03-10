import SwiftUI

struct AlbumsListView<Content: View>: View {
    private var albums: [Album]
    private let numberOfColumns: Int
    private let rowBuilder: (Album) -> Content
    private let onItemTapped: (Album) -> Void
    
    init(
        albums: [Album],
        numberOfColumns: Int = 2,
        @ViewBuilder rowBuilder: @escaping (Album) -> Content,
        onItemTapped: @escaping (Album) -> Void
    ) {
        self.albums = albums
        self.numberOfColumns = numberOfColumns
        self.rowBuilder = rowBuilder
        self.onItemTapped = onItemTapped
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns, spacing: 16
            ) {
                ForEach(albums, id: \.id) { album in
                    rowBuilder(album)
                        .onTapGesture {
                            onItemTapped(album)
                        }
                }
            }
            .padding(numberOfColumns == 1 ? 0 : 16)
        }
        
//                if let onSearchSubmit {
//                    TextField("Search...", text: $searchQuery)
//                        .padding()
//                        .background(
//                            Capsule()
//                                .fill(Color.gray.opacity(0.3))
//                        )
//                        .padding()
//                        .onSubmit {
//                            onSearchSubmit(searchQuery)
//                        }
//                }
//            }
    }
    
    private var columns: [GridItem] {
        Array(
            repeating: GridItem(.flexible()),
            count: numberOfColumns
        )
    }
}

#if DEBUG
#Preview {
    var previewAlbums: [Album] = [
        .previewEminemMock,
        .previewSoadMock,
        .previewLinkinParkMock
    ]
    
    return AlbumsListView(
        albums: previewAlbums,
        numberOfColumns: 2,
        rowBuilder: { album in
            AlbumListGalleryRow(album: album)
        },
        onItemTapped: { album in
            print("Hello, \(album.artist.name)!")
        }
    )
}
#endif
