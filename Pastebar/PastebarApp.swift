import SwiftUI

@main
struct PastebarApp: App {
    var body: some Scene {
        MenuBarExtra("Clipbar", systemImage: "paperclip.circle.fill") {
            ContentView()
        }.menuBarExtraStyle(.window)
    }
}
