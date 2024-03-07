import Foundation

protocol AlbumsDataSource {
    func search(album query: String) async throws -> AlbumSearchResultsDTO
}

struct AlbumsDataSourceImplementation: AlbumsDataSource {
    private let apiClient: NetworkClient
    
    init(apiClient: NetworkClient) {
        self.apiClient = apiClient
    }
    
    func search(album query: String) async throws -> AlbumSearchResultsDTO {
        try await apiClient.perform(request: AlbumSearchRequest(query: query))
    }
}
