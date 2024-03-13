import Foundation
import SwiftData

enum FavouriteTracksViewFactory {
    static func make(container: ModelContainer) -> FavouriteTracksView {
        let tracksDatasource = TracksDataSourceImplementation(container: container)
        let tracksRepository = TracksRepositoryImplementation(tracksDataSource: tracksDatasource)
        let getFavouriteTracksUseCase = GetFavouriteTracksUseCaseImplementation(tracksRepository: tracksRepository)
        let updateFavouriteTracksUseCase = UpdateFavouriteTracksUseCaseImplementation(tracksRepository: tracksRepository)
        
        let viewModel = FavouriteTracksViewModel(
            getFavouriteTracksUseCase: getFavouriteTracksUseCase,
            updateFavouriteTracksUseCase: updateFavouriteTracksUseCase
        )
        
        return FavouriteTracksView(viewModel: viewModel)
    }
}
