import SwiftUI

struct AlbumDetailsView: View {
    let album: Album
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    AsyncImage(url: album.coverUrl(size: .large))
                        .overlay {
                            Rectangle()
                                .fill(.black.opacity(0.6))
                        }
                    
                    VStack {
                        Spacer()
                        AsyncImage(url: album.artist.pictureMediumUrl)
                            .clipShape(Circle())
                            .background(
                                Circle()
                                    .stroke(.gray, lineWidth: 10)
                                
                            )
                            .shadow(radius: 7)
                            .offset(y: 80)
                    }
                }
                .padding(.bottom, 100)
                
                Text("Track list")
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

#if DEBUG
#Preview {
    AlbumDetailsView(album: .previewEminemMock)
}
#endif
