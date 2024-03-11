import Foundation
import SwiftUI
import SwiftData

@Observable
class AlbumsListRouter {
    enum Destination: Codable, Hashable {
        case albumDetails(id: Int)
    }
    
    var navigationPath: NavigationPath = NavigationPath()
    let container: ModelContainer
    
    init(container: ModelContainer) {
        self.container = container
    }
    
    func view(for destination: Destination) -> AnyView {
        switch destination {
        case .albumDetails(let id):
            AnyView(
                AlbumDetailsViewFactory.make(albumId: id, container: container)
            )
        }
    }
}

extension NavigationPath {
    mutating func navigate(to destination: AlbumsListRouter.Destination) {
        self.append(destination)
    }
    
    mutating func navigateBack() {
        self.removeLast()
    }
}
