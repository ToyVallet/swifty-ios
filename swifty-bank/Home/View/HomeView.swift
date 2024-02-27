import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var debugWebViewModel: WebViewModel
    @State var debugViewRouter: ViewRouter
    
    @Environment(\.presentationMode) var presentationMode
    
    let urls = [
        "https://weather.naver.com",
        "http://aim5.iptime.org:3030",
        "https://swifty-frontend-swifty-bank.vercel.app/agreement",
        "https://swifty-frontend-swifty-bank.vercel.app/sms-verification?name=hello",
        "https://swifty-frontend-swifty-bank.vercel.app/"
    ]
    
    var body: some View {
        VStack(alignment: .center, content: {
            ForEach(urls, id: \.self) { item in
                VStack{
                    Spacer()
                        .frame(height: 10)
                    Button(action: {
                        debugWebViewModel.url = item
                        debugViewRouter.currentPage = .test_webview
                    }, label: {
                        Text(item)
                    })
                }
            }
            Spacer()
                .frame(height: 50)
            Button(action: {
                debugViewRouter.currentPage = .test_webview
            }, label: {
                Text("Move to URL")
                    .font(.title3)
            })
            TextEditor(text: $debugWebViewModel.url)
                .frame(height: 160)
                .keyboardType(.URL)
            Spacer()
                .frame(height: 30)
            Text(UIDevice.current.identifierForVendor?.uuidString ?? "UUID unavailable")
        })
        .padding(EdgeInsets(top: 6, leading: 13, bottom: 6, trailing: 13))
    }
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(debugWebViewModel: WebViewModel(), debugViewRouter: ViewRouter())
            .environmentObject(HomeViewModel())
    }
}
