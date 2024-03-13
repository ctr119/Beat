import Foundation
import SwiftUI

extension View {
    func loadingState<T>(_ state: ViewModelState<T>) -> some View {
        modifier(ViewLoadingStateModifier(state: state))
    }
}

private struct ViewLoadingStateModifier<T>: ViewModifier {
    var state: ViewModelState<T> = ViewModelState.idle
    
    func body(content: Content) -> some View {
        switch state {
        case .idle, .loaded:
            content
        case .loading:
            content
                .overlay {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.7))
                        .tint(Color.black)
                        .controlSize(.large)
                }
        case .failed(let error):
            content
                .overlay {
                    Text(error.localizedDescription)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.7))
                }
        }
    }
}
