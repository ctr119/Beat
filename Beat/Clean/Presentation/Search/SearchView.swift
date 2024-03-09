import SwiftUI

struct SearchView: View {
    @State private var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: {
                Task {
                    await viewModel.performSearch(query: "tokio")
                }
            })
        case .loading:
            ProgressView()
        case .failed(let error):
            Text(error.localizedDescription)
        case .loaded(let value):
            AlbumsListView(
                screenTitle: "Search",
                albums: value
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
