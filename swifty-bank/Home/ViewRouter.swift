import SwiftUI


class ViewRouter: ObservableObject {
    @Published var currentPage: Page = .initial
    @Published var isWebViewMarginTop = true
    @Published var isWebViewMarginBottom = true
    @Published var isShadow = false
    @Published var shadowAlpha = 0.25
    @Published var isTabBar = true
    
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
