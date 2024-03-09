import Foundation
import SwiftUI

@Observable
class AlbumsListRouter {
    enum Destination: Codable, Hashable {
        case albumDetails(id: Int)
    }
    
    var navigationPath: NavigationPath = NavigationPath()
    
    func view(for destination: Destination) -> AnyView {
        switch destination {
        case .albumDetails(let id):
            AnyView(
                AlbumDetailsViewFactory.make(albumId: id)
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
