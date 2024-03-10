import Foundation

protocol SearchAlbumsUseCase {
    func callAsFunction(query: String) async -> [Album]
}

struct SearchAlbumsUseCaseImplementation: SearchAlbumsUseCase {
    private let albumsRepository: AlbumsRepository
    
    init(albumsRepository: AlbumsRepository) {
        self.albumsRepository = albumsRepository
    }
    
    func callAsFunction(query: String) async -> [Album] {
        await albumsRepository.searchAlbum(with: query, limit: 30)
    }
}

#if DEBUG
struct SearchAlbumsUseCasePreviewMock: SearchAlbumsUseCase {
    func callAsFunction(query: String) async -> [Album] {
        [
            .previewSoadMock,
            .previewLinkinParkMock
        ]
    }
}
#endif
