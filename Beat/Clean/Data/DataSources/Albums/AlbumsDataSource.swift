import Foundation

protocol AlbumsDataSource {
    func getAlbumDetails(id: Int) async throws -> AlbumDTO
    func search(album query: String, limit: Int) async throws -> AlbumSearchResultsDTO
}

struct AlbumsDataSourceImplementation: AlbumsDataSource {
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    func getAlbumDetails(id: Int) async throws -> AlbumDTO {
        try await apiClient.perform(request: AlbumDetailsRequest(albumId: id))
    }
    
    func search(album query: String, limit: Int) async throws -> AlbumSearchResultsDTO {
        try await apiClient.perform(
            request: AlbumSearchRequest(
                query: query,
                limit: limit
            )
        )
    }
}
