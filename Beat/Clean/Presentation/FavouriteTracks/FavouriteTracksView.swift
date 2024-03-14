import SwiftUI

struct FavouriteTracksView: View {
    @State private var editMode: EditMode = .inactive
    
    @State var viewModel: FavouriteTracksViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.tracks, id: \.id) { track in
                    trackRowView(track)
                }
                .onMove { from, to in
                    viewModel.moveTrack(fromOffsets: from, toOffset: to)
                    
                    if !editMode.isEditing {
                        viewModel.save()
                    }
                }
                .onDelete { indexSet in
                    viewModel.deleteTrack(atOffsets: indexSet)
                    
                    if !editMode.isEditing {
                        viewModel.save()
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(editMode == .inactive ? "Edit" : "Done") {
                        editMode = editMode == .inactive ? .active : .inactive
                        
                        if editMode == .inactive {
                            viewModel.save()
                        }
                    }
                }
            }
            .animation(.easeInOut, value: editMode)
            .onAppear {
                viewModel.loadTracks()
            }
        }
    }
    
    private func trackRowView(_ track: Track) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(track.title)
                    .font(.headline)
                
                Text(track.artistName)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text(track.durationInSeconds, format: .timerCountdown)
        }
        .padding(4)
        .monospaced()
    }
}

#if DEBUG
#Preview {
    FavouriteTracksView(
        viewModel: .init(
            getFavouriteTracksUseCase: GetFavouriteTracksUseCasePreviewMock(),
            updateFavouriteTracksUseCase: UpdateFavouriteTracksUseCasePreviewMock()
        )
    )
}
#endif
