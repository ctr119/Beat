import Foundation

protocol AlbumsRepository {
    func getDetails(of albumId: Int) async throws -> Album
    func searchAlbum(with query: String) async -> [Album]
}

struct AlbumsRepositoryImplementation: AlbumsRepository {
    private let albumsDataSource: AlbumsDataSource
    
    init(albumsDataSource: AlbumsDataSource) {
        self.albumsDataSource = albumsDataSource
    }
    
    func getDetails(of albumId: Int) async throws -> Album {
        do {
            let albumDTO = try await albumsDataSource.getAlbumDetails(id: albumId)
            guard let album = albumDTO.toDomain else {
                throw DomainError.malformedData
            }
            return album
            
        } catch is DataError {
            throw DomainError.networkIssue
        } catch {
            throw error
        }
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
