import SwiftUI

@main
struct swifty_bankApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: ViewRouter())
        }
    }
}
