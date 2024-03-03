import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    @EnvironmentObject var webViewModel: WebViewModel
    var contentController = ContentController()
    
    @State var viewRouter: ViewRouter
    @State var safeAreaBottomHeight: CGFloat
    
    func makeUIView(context: Context) -> WKWebView {
        //        guard let url = URL(string: webViewModel.url) else{
        //            return WKWebView()
        //        }
        contentController.viewRouter = viewRouter
        
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.processPool = WKProcessPool()
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.applicationNameForUserAgent = "SwiftyIosApp"
        
        let webview = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 400), configuration: config)
        webview.allowsBackForwardNavigationGestures = false
        webview.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        webview.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        webview.scrollView.contentInsetAdjustmentBehavior = .never
        
        NotificationCenter.default.removeObserver(webview, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(webview, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(webview, name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        webview.configuration.userContentController.add(contentController, name: "bridge")
        
        
        guard let url = URL(string: webViewModel.url) else {
            return WKWebView()
        }
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WebView>){
    }
    
    class ContentController: NSObject, WKScriptMessageHandler {
        var viewRouter: ViewRouter?
        
        init(viewRouter: ViewRouter? = nil) {
            self.viewRouter = viewRouter
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            print(message)
            if message.name == "bridge"{
                //              {
                //                  "type" : "ui",
                //                  "action": "taptic-light",
                //                  "callback" : "alert('testing alert')"
                //              }
                
                let jsonDecoder = JSONDecoder()
                var bridge: Bridge?
                do {
                    let body = try? JSONSerialization.data(withJSONObject: message.body)
                    bridge = try jsonDecoder.decode(Bridge.self, from: body!)
                } catch {
                    print(error)
                }
                
                if bridge?.type == "ui"{
                    switch bridge?.action {
                    case "taptic-rigid":
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: .rigid)
                        feedbackGenerator.impactOccurred()
                    case "taptic-soft":
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
                        feedbackGenerator.impactOccurred()
                    case "taptic-heavy":
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
                        feedbackGenerator.impactOccurred()
                    case "taptic-medium":
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
                        feedbackGenerator.impactOccurred()
                    case "taptic-light":
                        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
                        feedbackGenerator.impactOccurred()
                    case "taptic-error":
                        let feedbackGenerator = UINotificationFeedbackGenerator()
                        feedbackGenerator.notificationOccurred(.error)
                    case "taptic-success":
                        let feedbackGenerator = UINotificationFeedbackGenerator()
                        feedbackGenerator.notificationOccurred(.success)
                    case "taptic-warning":
                        let feedbackGenerator = UINotificationFeedbackGenerator()
                        feedbackGenerator.notificationOccurred(.warning)
                    case "shadow-enable":
                        withAnimation(.easeInOut(duration: 0.4)){
                            viewRouter?.isShadow = true
                            viewRouter?.shadowAlpha = Double(bridge?.data ?? "0.25") ?? 0.25
                        }
                    case "shadow-disable":
                        withAnimation(.easeInOut(duration: 0.4)){
                            viewRouter?.isShadow = false
                            viewRouter?.shadowAlpha = Double(bridge?.data ?? "0.25") ?? 0.25
                        }
                    case "area-margin-top-enable":
                        withAnimation(.easeInOut(duration: 0.4)){
                            viewRouter?.isWebViewMarginTop = true
                        }
                    case "area-margin-top-disable":
                        withAnimation(.easeInOut(duration: 0.4)){
                            viewRouter?.isWebViewMarginTop = false
                        }
                    case "area-margin-bottom-enable":
                        withAnimation(.easeInOut(duration: 0.4)){
                            viewRouter?.isWebViewMarginBottom = true
                        }
                    case "area-margin-bottom-disable":
                        withAnimation(.easeInOut(duration: 0.4)){
                            viewRouter?.isWebViewMarginBottom = false
                        }
                    case "tabbar-enable":
                        withAnimation(.easeInOut(duration: 0.24)){
                            viewRouter?.isTabBar = true
                        }
                    case "tabbar-disable":
                        withAnimation(.easeInOut(duration: 0.24)){
                            viewRouter?.isTabBar = false
                        }
                    default:
                        print(bridge?.action ?? "empty action from webview")
                    }
                } else if bridge?.type == "data"{
                    if (bridge != nil) {
                        print(bridge!.callback)
                        message.webView?.evaluateJavaScript(bridge!.callback)
                    }
                }
                
                message.webView?.evaluateJavaScript("window.NativeInterface.receivedFromIos('\(UIDevice.current.identifierForVendor?.uuidString ?? "UUID unavailable")')")
                
                ///change "taptic" to "ui" and accept json only
                ///add json parser here
                
            }
        }
    }
}

struct WebView_Previews: PreviewProvider{
    static var previews: some View{
        WebView(viewRouter: ViewRouter(), safeAreaBottomHeight: 0)
            .environmentObject(WebViewModel())
    }
}
