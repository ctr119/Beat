import Foundation
import SwiftData

enum AlbumDetailsViewFactory {
    static func make(albumId: Int, container: ModelContainer) -> AlbumDetailsView {
        let dataSource = AlbumsDataSourceImplementation(apiClient: ApiClient())
        let repository = AlbumsRepositoryImplementation(albumsDataSource: dataSource)
        
        let tracksDataSource = TracksDataSourceImplementation(container: container)
        let tracksRepository = TracksRepositoryImplementation(tracksDataSource: tracksDataSource)
        
        let getAlbumDetailsUseCase = GetAlbumDetailsUseCaseImplementation(
            albumsRepository: repository,
            tracksRepository: tracksRepository
        )
        
        let updateTrackInFavouritesUseCase = UpdateTrackInFavouritesUseCaseImplementation(tracksRepository: tracksRepository)
        
        let viewModel = AlbumDetailsView.ViewModel(
            id: albumId,
            getAlbumDetailsUseCase: getAlbumDetailsUseCase,
            updateTrackInFavouritesUseCase: updateTrackInFavouritesUseCase
        )
        
        return AlbumDetailsView(viewModel: viewModel)
    }
}
