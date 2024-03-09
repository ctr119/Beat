import Foundation

protocol GetAlbumDetailsUseCase {
    func callAsFunction(id albumId: Int) async throws -> Album
}

struct GetAlbumDetailsUseCaseImplementation: GetAlbumDetailsUseCase {
    private let albumsRepository: AlbumsRepository
    
    init(albumsRepository: AlbumsRepository) {
        self.albumsRepository = albumsRepository
    }
    
    func callAsFunction(id albumId: Int) async throws -> Album {
        try await albumsRepository.getDetails(of: albumId)
    }
}

#if DEBUG
class GetAlbumDetailsUseCasePreviewMock: GetAlbumDetailsUseCase {
    func callAsFunction(id albumId: Int) async throws -> Album {
        .previewEminemMock
    }
}
#endif
