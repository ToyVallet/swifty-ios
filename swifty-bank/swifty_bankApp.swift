import SwiftUI

@main
struct swifty_bankApp: App {
    let uuid = UIDevice.current.identifierForVendor?.uuidString ?? "UUID unavailable"
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewRouter: ViewRouter())
                .background(.backgroundMaster)
        }
    }
}
