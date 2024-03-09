import SwiftUI

struct TopAlbumsView: View {
    private enum DisplayMode: String, CaseIterable {
        case gallery = "square.grid.2x2.fill"
        case list = "rectangle.grid.1x2.fill"
    }
    
    @State private var displayMode: DisplayMode = .gallery
    @State private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        AlbumsListView(
            screenTitle: "Top Albums",
            albums: viewModel.albums
        )
        .onAppear {
            Task {
                await viewModel.loadAlbums()
            }
        }
    }
}

#if DEBUG
#Preview {
    TopAlbumsView(viewModel: .previewMock)
}
#endif
