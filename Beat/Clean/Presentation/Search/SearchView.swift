import SwiftUI

struct SearchView: View {
    @State private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            AlbumsListView(
                screenTitle: "Explore",
                albums: viewModel.albums,
                onSearchSubmit: { searchQuery in
                    Task {
                        await viewModel.performSearch(query: searchQuery)
                    }
                }
            )
        }
    }
}

#if DEBUG
#Preview {
    SearchView(
        viewModel: .init(
            searchAlbumsUseCase: SearchAlbumsUseCasePreviewMock()
        )
    )
}
#endif
