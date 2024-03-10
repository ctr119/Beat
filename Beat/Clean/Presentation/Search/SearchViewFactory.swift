import Foundation

enum SearchViewFactory {
    static func make() -> SearchView {
        let dataSource = AlbumsDataSourceImplementation(apiClient: ApiClient())
        let repository = AlbumsRepositoryImplementation(albumsDataSource: dataSource)
        let searchAlbumsUseCase = SearchAlbumsUseCaseImplementation(albumsRepository: repository)
        let viewModel = SearchViewModel(searchAlbumsUseCase: searchAlbumsUseCase)
        
        return SearchView(viewModel: viewModel, router: AlbumsListRouter())
    }
}
