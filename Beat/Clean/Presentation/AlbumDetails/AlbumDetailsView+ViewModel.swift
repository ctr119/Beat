import Foundation

extension AlbumDetailsView {
    @Observable
    class ViewModel {
        private(set) var state: ViewModelState<Album> = .idle
        
        private let initialId: Int
        private let getAlbumDetailsUseCase: GetAlbumDetailsUseCase
        
        init(id: Int, getAlbumDetailsUseCase: GetAlbumDetailsUseCase) {
            self.initialId = id
            self.getAlbumDetailsUseCase = getAlbumDetailsUseCase
        }
        
        func loadDetails() async {
            do {
                state = .loading
                
                let albumDetails = try await getAlbumDetailsUseCase(id: initialId)
                await MainActor.run {
                    state = .loaded(albumDetails)
                }
            } catch {
                state = .failed(error)
            }
        }
    }
}
