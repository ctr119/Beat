import Foundation

#if DEBUG
extension Genre {
    static var previewHipHopMock: Genre {
        .init(id: 116, name: "Rap/Hip Hop")
    }
    
    static var previewRockMock: Genre {
        .init(id: 152, name: "Rock")
    }
    
    static var previewHardRockMock: Genre {
        .init(id: 155, name: "Hard Rock")
    }
    
    static var previewMetalMock: Genre {
        .init(id: 464, name: "Metal")
    }
    
    static var previewAlternativeMock: Genre {
        .init(id: 85, name: "Alternative")
    }
}
#endif
