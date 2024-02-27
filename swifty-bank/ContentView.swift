import SwiftUI
import CoreData
import RangeSeekSlider

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
                    WebView(safeAreaBottomHeight: geometry.safeAreaInsets.bottom)
                        .environmentObject(webViewModel)
                        .frame(width: frameWidth)
                        .transition(.offset(CGSize(width: 0, height: 0)))
                        .padding(EdgeInsets(top: geometry.safeAreaInsets.top, leading: 0, bottom: 0, trailing: 0))
//                          .ignoresSafeArea(edges: [.top])
                case .initial:
                    Spacer()
                }
                VStack{
                    Spacer()
                    VStack{
                        HStack(spacing: frameWidth/12){
                            TabBarItem(title: "홈", iconString: "Home", viewRouter: viewRouter, assignedPage: .test_home)
                            TabBarItem(title: "웹뷰", iconString: "Currency", viewRouter: viewRouter, assignedPage: .test_webview)
                            TabBarItem(title: "비밀번호", iconString: "MyPage", viewRouter: viewRouter)
                                .disabled(true)
                                .onTapGesture {
                                    isLoginPresented = true
                                }
                        }
                        Spacer()
                            .frame(height: 25)
                    }
                    .frame(width: frameWidth, height: DOCK_HEIGHT)
                    .background(.backgroundMaster)
                    .cornerRadius(25, corners: [.topLeft, .topRight])
                    .shadow(color: .black.opacity(0.15), radius: 6, x:0, y:-1)
                    .ignoresSafeArea(.keyboard)
                    .onAppear(perform: {
                        viewRouter.currentPage = .test_home
                    })
                }
                .ignoresSafeArea([.container, .keyboard])
            }
            .ignoresSafeArea(.container)
            .fullScreenCover(isPresented: $isLoginPresented){
                PasswordView()
                    .environmentObject(passwordViewModel)
                    .onDisappear(perform: {
                        print("closed")
                    })
            }
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
