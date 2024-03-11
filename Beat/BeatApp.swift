import SwiftUI
import SwiftData

@main
struct BeatApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: container)
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            let dbSchema = Schema([
                TrackDTO.self
            ])
            let configuration = ModelConfiguration(
                schema: dbSchema
            )
            
            container = try ModelContainer(for: dbSchema, configurations: configuration)
        } catch {
            fatalError("Failed to create ModelContainer for dbSchema.")
        }
    }
}
