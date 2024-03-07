import Foundation

struct GetTopAlbumsUseCase {
    private let albumsQueries = [
        "eminem"
    ]
    
    private let albumsRepository: AlbumsRepository
    
    init(albumsRepository: AlbumsRepository) {
        self.albumsRepository = albumsRepository
    }
    
    func callAsFunction() async {
        for query in albumsQueries {
            await albumsRepository.searchAlbum(with: query)
        }
    }
}
