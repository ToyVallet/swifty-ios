import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    var contentController = ContentController()
    @State var safeAreaBottomHeight: CGFloat
    
    @EnvironmentObject var webViewModel: WebViewModel
    
    func makeUIView(context: Context) -> WKWebView {
//        guard let url = URL(string: webViewModel.url) else{
//            return WKWebView()
//        }
        
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.processPool = WKProcessPool()
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.applicationNameForUserAgent = "SwiftyIosApp"
        
        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 400), configuration: config)
        webview.allowsBackForwardNavigationGestures = false
        webview.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        webview.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -safeAreaBottomHeight, right: 0)
        webview.scrollView.contentInsetAdjustmentBehavior = .never
        
        NotificationCenter.default.removeObserver(webview, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(webview, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(webview, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        webview.configuration.userContentController.add(contentController, name: "bridge")
        webview.configuration.userContentController.add(contentController, name: "taptic")
        
    
        guard let url = URL(string: webViewModel.url) else {
            return WKWebView()
        }
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WebView>){
    }
    
    class ContentController: NSObject, WKScriptMessageHandler {
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            print(message)
            if message.name == "bridge"{
                ///add json parser here
                ///add uuid generator here
                print(message.body)
                message.webView?.evaluateJavaScript("window.NativeInterface.receivedFromIos('test')")
                message.webView?.evaluateJavaScript("localStorage.val = 'test'")
            }
            else if message.name == "taptic"{
                ///change "taptic" to "ui" and accept json only
                ///add json parser here
                let feedbackGenerator: UIImpactFeedbackGenerator
                switch message.body as? String ?? "light" {
                case "rigid":
                    feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
                case "soft":
                    feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
                case "heavy":
                    feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                case "medium":
                    feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
                case "light":
                    feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                default:
                    feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                }
                feedbackGenerator.prepare()
                feedbackGenerator.impactOccurred()
            }
        }
    }
}

struct WebView_Previews: PreviewProvider{
    static var previews: some View{
        WebView(safeAreaBottomHeight: 0)
            .environmentObject(WebViewModel())
    }
}
