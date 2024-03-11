import Foundation
import SwiftData

enum TopAlbumsViewFactory {
    static func make(container: ModelContainer) -> TopAlbumsView {
        let dataSource = AlbumsDataSourceImplementation(apiClient: ApiClient())
        let repository = AlbumsRepositoryImplementation(albumsDataSource: dataSource)
        let useCase = GetTopAlbumsUseCaseImplementation(albumsRepository: repository)
        let viewModel = TopAlbumsView.ViewModel(getTopAlbumsUseCase: useCase)
        
        return TopAlbumsView(viewModel: viewModel, router: AlbumsListRouter(container: container))
    }
}
