import Foundation
import SwiftUI

extension TopAlbumsView {
    @Observable
    class Router {
        enum Destination: Codable, Hashable {
            case albumDetails(id: Int)
        }
        
        var navigationPath: NavigationPath = NavigationPath()
        
        func view(for destination: Destination) -> AnyView {
            switch destination {
            case .albumDetails(let id):
                AnyView(
                    AlbumDetailsView(album: .previewEminemMock)
                )
            }
        }
    }
}

extension NavigationPath {
    mutating func navigate(to destination: TopAlbumsView.Router.Destination) {
        self.append(destination)
    }
    
    mutating func navigateBack() {
        self.removeLast()
    }
}
