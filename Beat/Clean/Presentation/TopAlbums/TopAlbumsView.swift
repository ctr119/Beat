import SwiftUI

struct TopAlbumsView: View {
    private enum DisplayMode: String, CaseIterable {
        case gallery = "square.grid.2x2.fill"
        case list = "rectangle.grid.1x2.fill"
    }
    
    @State private var displayMode: DisplayMode = .gallery
    @State private var albums: [Album] = [
        Album(
            id: 103248,
            title: "The Eminem Show",
            coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/56x56-000000-80-0-0.jpg")!,
            coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/250x250-000000-80-0-0.jpg")!,
            coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/ec3c8ed67427064c70f67e5815b74cef/500x500-000000-80-0-0.jpg")!,
            artist: Artist(id: 13, name: "Eminem")
        ),
        Album(
            id: 73123,
            title: "Mezmerize",
            coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/56x56-000000-80-0-0.jpg")!,
            coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/250x250-000000-80-0-0.jpg")!,
            coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/4954f43cc6033ddfa0fa3ee5514a26ca/500x500-000000-80-0-0.jpg")!,
            artist: Artist(id: 458, name: "System of A Down")
        ),
        Album(
            id: 1346746,
            title: "Meteora",
            coverUrlSmall: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/56x56-000000-80-0-0.jpg")!,
            coverUrlMedium: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/250x250-000000-80-0-0.jpg")!,
            coverUrlLarge: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/882448ab63952aa16e502c82db2df160/500x500-000000-80-0-0.jpg")!,
            artist: Beat.Artist(id: 92, name: "Linkin Park")
        )
    ]
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: displayMode == .gallery ? 2 : 1)
    }
    
    init() {
        UISegmentedControl.appearance()
            .selectedSegmentTintColor = .systemPink
        
        UISegmentedControl.appearance()
            .setTitleTextAttributes(
                [.foregroundColor: UIColor.white],
                for: .selected
            )
        UISegmentedControl.appearance()
            .setTitleTextAttributes(
                [.foregroundColor: UIColor.gray],
                for: .normal
            )
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(
                    columns: columns, spacing: 16
                ) {
                    ForEach(albums, id: \.id) { album in
                        VStack {
                            AsyncImage(
                                url: album.coverUrl(size: .large),
                                transaction: .init(animation: .easeInOut)
                            ) { imagePhase in
                                imagePhase
                                    .image?
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            
                            Text(album.title)
                            Text(album.artist.name)
                        }
                    }
                }
                .padding(displayMode == .gallery ? 16 : 0)
            }
            .navigationTitle("Top Albums")
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
    }
}

#if DEBUG
#Preview {
    TopAlbumsView()
}
#endif
