import SwiftUI

struct AlbumDetailsView: View {
    @State var viewModel: ViewModel
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: {
                Task {
                    await viewModel.loadDetails()
                }
            })
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.3))
                .tint(Color.black)
                .controlSize(.large)
        case .failed(let error):
            Text(error.localizedDescription)
        case .loaded(let album):
            content(album: album)
        }
    }
    
    @ViewBuilder
    private func content(album: Album) -> some View {
        ScrollView {
            VStack(spacing: 30) {
                headingSection(album: album)
                
                albumInfoSection(album: album)
                
                trackList(album: album)
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    private func headingSection(album: Album) -> some View {
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
    
    private func albumInfoSection(album: Album) -> some View {
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
    
    private func trackList(album: Album) -> some View {
        VStack {
            Text("Tracks")
                .fontDesign(.serif)
                .font(.headline)
            
            VStack(spacing: 0) {
                ForEach(Array(zip(tracks(album).indices, tracks(album))), id: \.0) { index, track in
                    HStack {
                        Text("#\(index + 1).")
                        Text(track.title)
                        
                        Spacer()
                        
                        Text(track.durationInSeconds, format: .timerCountdown)
                    }
                    .monospaced()
                    .padding(6)
                    .background(
                        index.isMultiple(of: 2) ? Color.gray.opacity(0.4) : Color.clear
                    )
                }
            }
        }
    }
    
    private func tracks(_ album: Album) -> [Track] {
        album.tracks ?? []
    }
}

#if DEBUG
#Preview {
    AlbumDetailsView(
        viewModel: .init(
            id: 0,
            getAlbumDetailsUseCase: GetAlbumDetailsUseCasePreviewMock()
        )
    )
}
#endif
