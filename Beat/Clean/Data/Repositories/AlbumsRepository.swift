import Foundation

protocol AlbumsRepository {
    func searchAlbum(with query: String) async -> [Album]
}

struct AlbumsRepositoryImplementation: AlbumsRepository {
    private let albumsDataSource: AlbumsDataSource
    
    init(albumsDataSource: AlbumsDataSource) {
        self.albumsDataSource = albumsDataSource
    }
    
    func searchAlbum(with query: String) async -> [Album] {
        do {
            let albumSearchResultsDTO = try await albumsDataSource.search(album: query)
            return albumSearchResultsDTO.data.compactMap { $0.toDomain }
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}
