import SwiftUI

struct AlbumListRow: View {
    let album: Album
    
    var body: some View {
        ZStack {
            AsyncImage(
                url: album.coverUrl(size: .large),
                transaction: .init(animation: .easeInOut)
            ) { imagePhase in
                imagePhase
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading) {
                    Text(album.title)
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(album.artist.name)
                        .font(.subheadline)
                        .italic()
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white.opacity(0.5))
            }
        }
    }
}

#Preview {
    ZStack {
        Color.gray.opacity(0.7).ignoresSafeArea()
        
        AlbumListRow(album: .previewEminemMock)
    }
}
