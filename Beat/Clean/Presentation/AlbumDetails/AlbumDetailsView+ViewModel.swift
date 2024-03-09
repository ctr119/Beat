import Foundation

extension AlbumDetailsView {
    @Observable
    class ViewModel {
        private(set) var album: Album?
        
        private let initialId: Int
        private let getAlbumDetailsUseCase: GetAlbumDetailsUseCase
        
        init(id: Int, getAlbumDetailsUseCase: GetAlbumDetailsUseCase) {
            self.initialId = id
            self.getAlbumDetailsUseCase = getAlbumDetailsUseCase
        }
        
        func loadDetails() async {
            do {
                let albumDetails = try await getAlbumDetailsUseCase(id: initialId)
                await MainActor.run {
                    album = albumDetails
                }
            } catch {
                // change the state
            }
        }
    }
}
