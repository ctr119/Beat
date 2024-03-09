import Foundation
import SwiftUI

@Observable
class SearchViewModel {
    var state: ViewModelState<[Album]> = .idle
    
    private let searchAlbumsUseCase: SearchAlbumsUseCase
    
    init(searchAlbumsUseCase: SearchAlbumsUseCase) {
        self.searchAlbumsUseCase = searchAlbumsUseCase
    }
    
    func performSearch(query: String) async {
        state = .loading
        
        let results = await searchAlbumsUseCase(query: query)
        
        await MainActor.run {
            state = .loaded(results)
        }
    }
}
