import Foundation
import SwiftUI

@Observable
class SearchViewModel {
    var albums: [Album] = []
    
    private let searchAlbumsUseCase: SearchAlbumsUseCase
    
    init(searchAlbumsUseCase: SearchAlbumsUseCase) {
        self.searchAlbumsUseCase = searchAlbumsUseCase
    }
    
    func performSearch(query: String) async {
        let results = await searchAlbumsUseCase(query: query)
        
        await MainActor.run {
            albums = results
        }
    }
}
