import SwiftUI

struct AlbumDetailsView: View {
    @State var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                if case let .loaded(display) = viewModel.state {
                    headingSection(display: display)
                    
                    albumInfoSection(display: display)
                    
                    trackList(tracks: display.tracks)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea(.container, edges: .top)
        .loadingState(viewModel.state)
        .onAppear {
            Task {
                await viewModel.loadDetails()
            }
        }
    }
    
    private func headingSection(display: ViewDisplay) -> some View {
        VStack(spacing: 0) {
            AsyncImage(url: display.coverUrl) { imagePhase in
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
            
            AsyncImage(url: display.artist.pictureUrl(size: .medium)) { imagePhase in
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
    
    private func albumInfoSection(display: ViewDisplay) -> some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text(display.artist.name)
                    .font(.largeTitle)
                
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 60)
            }
            
            VStack {
                Text(display.title)
                    .font(.title2)
                
                Text(display.releaseDate?.toString ?? "")
                
                HStack {
                    ForEach(display.genres, id: \.id) { genre in
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
    
    private func trackList(tracks: [FavouriteItem<Track>]) -> some View {
        VStack {
            Text("Tracks")
                .fontDesign(.serif)
                .font(.headline)
            
            VStack(spacing: 0) {
                ForEach(Array(zip(tracks.indices, tracks)), id: \.0) { index, track in
                    HStack {
                        Text("#\(index + 1).")
                        Text(track.item.title)
                        
                        Spacer()
                        
                        Text(track.item.durationInSeconds, format: .timerCountdown)
                        
                        Button {
                            viewModel.didTapOnTrackHeart(track)
                        } label: {
                            Image(systemName: track.isFavourite ? "heart.fill" : "heart")
                                .foregroundStyle(Color.purple)
                        }
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
}

#if DEBUG
#Preview {
    AlbumDetailsView(
        viewModel: .init(
            id: 0,
            getAlbumDetailsUseCase: GetAlbumDetailsUseCasePreviewMock(), 
            updateTrackInFavouritesUseCase: UpdateTrackInFavouritesUseCasePreviewMock()
        )
    )
}
#endif
