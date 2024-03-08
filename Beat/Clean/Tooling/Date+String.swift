import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
}
