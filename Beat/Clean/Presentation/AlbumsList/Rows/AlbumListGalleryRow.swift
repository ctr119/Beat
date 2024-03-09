import SwiftUI

struct AlbumListGalleryRow: View {
    let album: Album
    
    var body: some View {
        VStack(spacing: 10) {
            AsyncImage(
                url: album.coverUrl(size: .large),
                transaction: .init(animation: .easeInOut)
            ) { imagePhase in
                imagePhase
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
            .shadow(
                color: .black,
                radius: 4,
                x: 5,
                y: 5
            )
            
            VStack {
                Text(album.title)
                    .font(.headline)
                
                Text(album.artist.name)
                    .font(.subheadline.italic())
            }
        }
    }
}

#if DEBUG
#Preview {
    AlbumListGalleryRow(album: .previewEminemMock)
}
#endif
