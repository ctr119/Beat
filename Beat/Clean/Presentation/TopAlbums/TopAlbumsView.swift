import SwiftUI

struct TopAlbumsView: View {
    private enum DisplayMode: String, CaseIterable {
        case gallery = "square.grid.2x2.fill"
        case list = "rectangle.grid.1x2.fill"
    }
    
    @State private var displayMode: DisplayMode = .gallery
    @State private var viewModel: ViewModel
    @State private var router: Router
    
    init(viewModel: ViewModel, router: Router) {
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
            ScrollView {
                LazyVGrid(
                    columns: columns, spacing: 16
                ) {
                    ForEach(viewModel.albums, id: \.id) { album in
                        row(for: album)
                            .onTapGesture {
                                router
                                    .navigationPath
                                    .navigate(to: .albumDetails(id: album.id))
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
            .task {
                await viewModel.loadAlbums()
            }
            .navigationDestination(for: Router.Destination.self) { destination in
                router.view(for: destination)
            }
        }
    }
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: displayMode == .gallery ? 2 : 1)
    }
    
    @ViewBuilder
    private func row(for album: Album) -> some View {
        if displayMode == .gallery {
            galleryRow(for: album)
        } else {
            listRow(for: album)
        }
    }
    
    private func galleryRow(for album: Album) -> some View {
        VStack(spacing: 10) {
            AsyncImage(
                url: album.coverUrl(size: .large),
                transaction: .init(animation: .easeInOut)
            ) { imagePhase in
                imagePhase
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .shadow(
                color: .black,
                radius: 4,
                x: 5,
                y: 5
            )
            
            VStack {
                Text(album.title)
                    .font(.headline)
                
                Text(album.artist.name)
                    .font(.subheadline.italic())
            }
        }
    }
    
    private func listRow(for album: Album) -> some View {
        ZStack {
            AsyncImage(
                url: album.coverUrl(size: .large),
                transaction: .init(animation: .easeInOut)
            ) { imagePhase in
                imagePhase
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(album.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(album.artist.name)
                        .font(.subheadline)
                        .italic()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.5))
            }
        }
    }
}

#if DEBUG
#Preview {
    TopAlbumsView(viewModel: .previewMock, router: .init())
}
#endif
