import Foundation

protocol GetAlbumDetailsUseCase {
    func callAsFunction(id albumId: Int) async throws -> (album: Album, favouriteTracksIds: [Int])
}

struct GetAlbumDetailsUseCaseImplementation: GetAlbumDetailsUseCase {
    private let albumsRepository: AlbumsRepository
    private let tracksRepository: TracksRepository
    
    init(albumsRepository: AlbumsRepository, tracksRepository: TracksRepository) {
        self.albumsRepository = albumsRepository
        self.tracksRepository = tracksRepository
    }
    
    func callAsFunction(id albumId: Int) async throws -> (album: Album, favouriteTracksIds: [Int]) {
        let album = try await albumsRepository.getDetails(of: albumId)
        let tracksIds = album.tracks?.map { $0.id } ?? []
        let favouriteTracksIds = tracksRepository.getFavouriteTracks(tracksIds).map { $0.item.id }
        
        return (album, favouriteTracksIds)
    }
}

#if DEBUG
class GetAlbumDetailsUseCasePreviewMock: GetAlbumDetailsUseCase {
    func callAsFunction(id albumId: Int) async throws -> (album: Album, favouriteTracksIds: [Int]) {
        (.previewEminemMock, [])
    }
}
#endif
