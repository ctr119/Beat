import Foundation

enum AlbumDetailsViewFactory {
    static func make(albumId: Int) -> AlbumDetailsView {
        let dataSource = AlbumsDataSourceImplementation(apiClient: ApiClient())
        let repository = AlbumsRepositoryImplementation(albumsDataSource: dataSource)
        let useCase = GetAlbumDetailsUseCaseImplementation(albumsRepository: repository)
        let viewModel = AlbumDetailsView.ViewModel(
            id: albumId,
            getAlbumDetailsUseCase: useCase
        )
        
        return AlbumDetailsView(viewModel: viewModel)
    }
}
