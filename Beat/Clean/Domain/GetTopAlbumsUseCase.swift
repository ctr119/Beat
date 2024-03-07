import Foundation

struct GetTopAlbumsUseCase {
    private let albumsQueries = [
        "eminem", "soad"
    ]
    
    private let albumsRepository: AlbumsRepository
    
    init(albumsRepository: AlbumsRepository) {
        self.albumsRepository = albumsRepository
    }
    
    func callAsFunction() async -> [Album] {
        await withTaskGroup(of: [Album].self) { group -> [Album] in
            for query in albumsQueries {
                group.addTask {
                    await albumsRepository.searchAlbum(with: query)
                }
            }
            
            return await group.reduce(into: [Album]()) { partialResult, taskAlbums in
                partialResult += taskAlbums
            }
        }
    }
}
