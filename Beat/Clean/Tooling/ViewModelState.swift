import Foundation

enum ViewModelState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}
