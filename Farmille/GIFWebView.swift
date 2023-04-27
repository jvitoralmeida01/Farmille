import SwiftUI
import WebKit

struct GIFWebView: UIViewRepresentable {
    let gifName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.contentMode = .scaleAspectFit
        webView.clipsToBounds = true
        webView.isUserInteractionEnabled = false
        
        if let gifURL = Bundle.main.url(forResource: gifName, withExtension: "gif"),
           let gifData = try? Data(contentsOf: gifURL) {
            let baseURL = gifURL.deletingLastPathComponent()
            webView.load(gifData, mimeType: "image/gif", characterEncodingName: "utf-8", baseURL: baseURL)
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
