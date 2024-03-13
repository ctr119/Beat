import Foundation
import SwiftUI

extension AlbumDetailsView {
    enum AlbumDetailsError: Error {
        case operationFailed
    }
    
    @Observable
    class ViewModel {
        private(set) var state: ViewModelState<ViewDisplay> = .idle
        
        private let initialId: Int
        private let getAlbumDetailsUseCase: GetAlbumDetailsUseCase
        private let updateTrackInFavouritesUseCase: UpdateTrackInFavouritesUseCase
        
        init(
            id: Int,
            getAlbumDetailsUseCase: GetAlbumDetailsUseCase,
            updateTrackInFavouritesUseCase: UpdateTrackInFavouritesUseCase
        ) {
            self.initialId = id
            self.getAlbumDetailsUseCase = getAlbumDetailsUseCase
            self.updateTrackInFavouritesUseCase = updateTrackInFavouritesUseCase
        }
        
        func loadDetails() async {
            do {
                withAnimation {
                    state = .loading
                }
                
                let albumDetails = try await getAlbumDetailsUseCase(id: initialId)
                let tracks = albumDetails.album.tracks?.map {
                    FavouriteItem(item: $0, isFavourite: albumDetails.favouriteTracksIds.contains($0.id))
                } ?? []
                
                let viewDisplay = ViewDisplay(
                    id: albumDetails.album.id,
                    title: albumDetails.album.title,
                    coverUrl: albumDetails.album.coverUrl(size: .large),
                    artist: albumDetails.album.artist,
                    genres: albumDetails.album.genres ?? [],
                    releaseDate: albumDetails.album.releaseDate,
                    tracks: tracks
                )
                
                await MainActor.run {
                    withAnimation {
                        state = .loaded(viewDisplay)
                    }
                }
            } catch {
                withAnimation {
                    state = .failed(error)
                }
            }
        }
        
        func didTapOnTrackHeart(_ track: FavouriteItem<Track>) {
            do {
                if case let .loaded(display) = state {
                    try updateTrackInFavouritesUseCase(track) // this can throw SwiftData errors... find the type!
                    
                    var displayTracks = display.tracks
                    
                    let updatedTrack = FavouriteItem(item: track.item, isFavourite: !track.isFavourite)
                    let indexes = displayTracks
                        .enumerated()
                        .filter { _, item in
                            item.item.id == updatedTrack.item.id
                        }
                        .map { index, _ in
                            index
                        }
                    
                    guard let index = indexes.first,
                          index < displayTracks.count else {
                        throw AlbumDetailsError.operationFailed
                    }
                    
                    displayTracks[index] = updatedTrack
                    let newDisplay = display.clone(with: displayTracks)
                    state = .loaded(newDisplay)
                } else {
                    throw AlbumDetailsError.operationFailed
                }
            } catch {
                /// We could categorise errors in two:
                /// - Primary errors: important ones for the right display of the content -> these should replace the "happy" content with an error screen, i.e
                /// - Secondary errors: operational ones -> when an action gets triggered and fails -> these should not replace the content with an error screen, but probably displaying any kind of alert or toast
            }
        }
    }
}
