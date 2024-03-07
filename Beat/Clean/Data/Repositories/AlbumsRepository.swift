import Foundation

protocol AlbumsRepository {
    
}

struct AlbumsRepositoryImplementation: AlbumsRepository {
    private let albumsDataSource: AlbumsDataSource
    
    init(albumsDataSource: AlbumsDataSource) {
        self.albumsDataSource = albumsDataSource
    }
    
    func searchAlbum(with query: String) async {
        do {
            let albumSearchResultsDTO = try await albumsDataSource.search(album: query)
        } catch {
            print(error.localizedDescription)
        }
    }
}
