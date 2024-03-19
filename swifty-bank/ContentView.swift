import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var viewRouter: ViewRouter
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isLoginPresented = false
    
    @StateObject var passwordViewModel = PasswordViewModel()
    @StateObject var webViewModel = WebViewModel()
    @StateObject var homeViewModel = HomeViewModel()
    
    
    let frameWidth = UIScreen.main.bounds.width
    let frameHeight = UIScreen.main.bounds.height - DOCK_HEIGHT
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                switch viewRouter.currentPage {
                case .test_home:
                    HomeView(debugWebViewModel: webViewModel, debugViewRouter: viewRouter)
                        .environmentObject(homeViewModel)
                        .frame(width: frameWidth, height: frameHeight)
                        .transition(.offset(CGSize(width: 0, height: 0)))
                case .test_webview:
                    WebView(viewRouter: viewRouter, safeAreaBottomHeight: viewRouter.isWebViewMarginBottom ? geometry.safeAreaInsets.bottom : 0)
                        .environmentObject(webViewModel)
                        .frame(width: frameWidth)
                        .transition(.offset(CGSize(width: 0, height: 0)))
                        .padding(EdgeInsets(top: viewRouter.isWebViewMarginTop ? geometry.safeAreaInsets.top : 0, leading: 0, bottom: viewRouter.isWebViewMarginBottom ? geometry.safeAreaInsets.bottom : 0, trailing: 0))
//                          .ignoresSafeArea(edges: [.top])
                case .initial:
                    Spacer()
                }
            }
            .ignoresSafeArea(.container)
            .background(.black.opacity(viewRouter.isShadow ? viewRouter.shadowAlpha : 0))
            .fullScreenCover(isPresented: $isLoginPresented){
                PasswordView()
                    .environmentObject(passwordViewModel)
                    .onDisappear(perform: {
                        print("closed")
                    })
            }
            .onAppear(perform: {
                viewRouter.currentPage = .test_home
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewRouter: ViewRouter())
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
