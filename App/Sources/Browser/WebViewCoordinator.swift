import Foundation
import WebKit

enum WebViewCoordinator {
    static func makeConfig() -> WKWebViewConfiguration {
        let configuration = WKWebViewConfiguration()
        let controller = WKUserContentController()

        if let bootScript = loadScript(named: "boot"),
           let loaderScript = loadScript(named: "adapter-loader") {
            let bootUserScript = WKUserScript(source: bootScript, injectionTime: .atDocumentStart, forMainFrameOnly: false)
            let loaderUserScript = WKUserScript(source: loaderScript, injectionTime: .atDocumentEnd, forMainFrameOnly: false)

            controller.addUserScript(bootUserScript)
            controller.addUserScript(loaderUserScript)
        }

        controller.add(AIMessageHandler(), name: "ai")
        configuration.userContentController = controller

        ContentRules.compile { list in
            guard let list else { return }
            controller.add(list)
        }

        return configuration
    }

    private static func loadScript(named name: String) -> String? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "js") else { return nil }
        return try? String(contentsOf: url)
    }
}

final class AIMessageHandler: NSObject, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        NSLog("Received message from JS: \(message.body)")
    }
}
