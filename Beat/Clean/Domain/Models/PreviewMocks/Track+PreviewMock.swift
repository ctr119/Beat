import Foundation

#if DEBUG
extension [Track] {
    static var previewEminemTracks: [Track] {
        [
            .init(id: 916409, title: "Curtains Up (Skit)", durationInSeconds: 29, artistName: "Eminem"),
            .init(id: 916412, title: "White America", durationInSeconds: 324, artistName: "Eminem"),
            .init(id: 916413, title: "Business", durationInSeconds: 251, artistName: "Eminem")
        ]
    }
    
    static var previewSoadTracks: [Track] {
        [
            .init(id: 559787, title: "Soldier Side - Intro", durationInSeconds: 63, artistName: "System of a Down"),
            .init(id: 559789, title: "B.Y.O.B.", durationInSeconds: 255, artistName: "System of a Down"),
            .init(id: 559790, title: "Revenga", durationInSeconds: 228, artistName: "System of a Down")
        ]
    }
    
    static var previewLinkinParkTracks: [Track] {
        [
            .init(id: 14628993, title: "Foreword", durationInSeconds: 13, artistName: "Linkin Park"),
            .init(id: 14628994, title: "Don't Stay", durationInSeconds: 187, artistName: "Linkin Park"),
            .init(id: 14628995, title: "Somewhere I Belong", durationInSeconds: 214, artistName: "Linkin Park")
        ]
    }
}
#endif
