import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .initial
    
    func apply(page: Page) {
        withAnimation(.easeInOut(duration: 0.25)){
            impactLight.impactOccurred()
            currentPage = page
        }
    }
}

enum Page {
    case initial
    case test_home
    case test_webview
}
