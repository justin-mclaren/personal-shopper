import SwiftUI
import WebKit

struct BrowserView: View {
    @State private var urlString: String = "https://example.com"
    @State private var webView = WKWebView(frame: .zero, configuration: WebViewCoordinator.makeConfig())

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Search or enter address", text: $urlString, onCommit: load)
                    .textFieldStyle(.roundedBorder)
                Button("Go", action: load)
            }
            .padding(8)

            WebView(webView: webView)
        }
    }

    private func load() {
        guard let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
}

#Preview {
    BrowserView()
}
