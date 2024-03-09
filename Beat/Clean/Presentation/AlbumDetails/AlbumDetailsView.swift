import SwiftUI

struct AlbumDetailsView: View {
    let album: Album
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                headingSection
                
                albumInfoSection
                
                Text("Track list")
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private var headingSection: some View {
        VStack(spacing: 0) {
            AsyncImage(url: album.coverUrl(size: .large)) { imagePhase in
                imagePhase
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
            }
            .overlay {
                Rectangle()
                    .fill(.black.opacity(0.6))
            }
            
            AsyncImage(url: album.artist.pictureUrl(size: .medium)) { imagePhase in
                imagePhase
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
            }
            .clipShape(Circle())
            .background(
                Circle()
                    .stroke(.gray, lineWidth: 10)
                
            )
            .shadow(radius: 7)
            .offset(y: -75.0)
        }
        .padding(.bottom, -75.0)
    }
    
    private var albumInfoSection: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text(album.artist.name)
                    .font(.largeTitle)
                
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 60)
            }
            
            VStack {
                Text(album.title)
                    .font(.title2)
                
                Text(album.releaseDate?.toString ?? "")
                
                HStack {
                    ForEach(album.genres ?? [], id: \.id) { genre in
                        Text("#\(genre.name)")
                            .font(.callout.monospaced())
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.yellow)
                            )
                    }
                }
            }
        }
        .fontDesign(.serif)
        .foregroundStyle(.black.opacity(0.7))
    }
}

#if DEBUG
#Preview {
    AlbumDetailsView(album: .previewEminemMock)
}
#endif
