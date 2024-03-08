import Foundation

extension AlbumDTO {
    var toDomain: Album? {
        guard let small = URL(string: self.coverSmall),
              let medium = URL(string: self.coverMedium),
              let large = URL(string: self.coverLarge),
              let artist = self.artist.toDomain else { return nil }
        
        return .init(
            id: self.id,
            title: self.title,
            coverUrlSmall: small,
            coverUrlMedium: medium,
            coverUrlLarge: large,
            artist: artist,
            genres: self.genres?.data.map { $0.toDomain },
            releaseDate: releaseDate?.toDate,
            tracks: self.tracks?.data.map { $0.toDomain }
        )
    }
}

extension String {
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: self)
    }
}
