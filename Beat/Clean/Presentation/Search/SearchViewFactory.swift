import Foundation
import SwiftData

enum SearchViewFactory {
    static func make(container: ModelContainer) -> SearchView {
        let dataSource = AlbumsDataSourceImplementation(apiClient: ApiClient())
        let repository = AlbumsRepositoryImplementation(albumsDataSource: dataSource)
        let searchAlbumsUseCase = SearchAlbumsUseCaseImplementation(albumsRepository: repository)
        let viewModel = SearchViewModel(searchAlbumsUseCase: searchAlbumsUseCase)
        
        return SearchView(viewModel: viewModel, router: AlbumsListRouter(container: container))
    }
}
