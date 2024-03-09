import Foundation
import SwiftUI

extension TopAlbumsView {
    @Observable
    class ViewModel {
        var albums: [Album] = []
        
        private let getTopAlbumsUseCase: GetTopAlbumsUseCase
        
        init(getTopAlbumsUseCase: GetTopAlbumsUseCase) {
            self.getTopAlbumsUseCase = getTopAlbumsUseCase
        }
        
        func loadAlbums() async {
            let mAlbums = await getTopAlbumsUseCase()
            
            await MainActor.run {
                albums = mAlbums
            }
        }
    }
}

#if DEBUG
extension TopAlbumsView.ViewModel {
    static var previewMock: TopAlbumsView.ViewModel {
        .init(getTopAlbumsUseCase: GetTopAlbumsUseCasePreviewMock())
    }
}
#endif
