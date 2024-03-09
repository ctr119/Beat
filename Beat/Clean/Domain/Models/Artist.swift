import Foundation

struct Artist {
    let id: Int
    let name: String
    private let pictureSmallUrl: URL
    private let pictureMediumUrl: URL
    private let pictureLargeUrl: URL
    private let pictureXLargeUrl: URL
    
    init(
        id: Int,
        name: String,
        pictureSmallUrl: URL,
        pictureMediumUrl: URL,
        pictureLargeUrl: URL,
        pictureXLargeUrl: URL
    ) {
        self.id = id
        self.name = name
        self.pictureSmallUrl = pictureSmallUrl
        self.pictureMediumUrl = pictureMediumUrl
        self.pictureLargeUrl = pictureLargeUrl
        self.pictureXLargeUrl = pictureXLargeUrl
    }
    
    func pictureUrl(size: ImageSize) -> URL {
        return switch size {
        case .small:
            pictureSmallUrl
        case .medium:
            pictureMediumUrl
        case .large:
            pictureLargeUrl
        case .xlarge:
            pictureXLargeUrl
        }
    }
}
