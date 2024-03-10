import Foundation
import SwiftUI

enum SearchError: Error, LocalizedError {
    case emptyBox
    
    var errorDescription: String? {
        switch self {
        case .emptyBox:
            "Type something!"
        }
    }
}

@Observable
class SearchViewModel {
    var state: ViewModelState<[Album]> = .idle
    
    private let searchAlbumsUseCase: SearchAlbumsUseCase
    
    init(searchAlbumsUseCase: SearchAlbumsUseCase) {
        self.searchAlbumsUseCase = searchAlbumsUseCase
    }
    
    func performSearch(query: String) async {
        state = .loading
        
        guard !query.isEmpty else {
            state = .failed(SearchError.emptyBox)
            return
        }
        
        let results = await searchAlbumsUseCase(query: query)
        
        await MainActor.run {
            state = .loaded(results)
        }
    }
}
