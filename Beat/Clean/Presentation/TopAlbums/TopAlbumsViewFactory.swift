import Foundation

enum TopAlbumsViewFactory {
    static func make() -> TopAlbumsView {
        let dataSource = AlbumsDataSourceImplementation(apiClient: ApiClient())
        let repository = AlbumsRepositoryImplementation(albumsDataSource: dataSource)
        let useCase = GetTopAlbumsUseCaseImplementation(albumsRepository: repository)
        let viewModel = TopAlbumsView.ViewModel(getTopAlbumsUseCase: useCase)
        
        return TopAlbumsView(viewModel: viewModel, router: .init())
    }
}
