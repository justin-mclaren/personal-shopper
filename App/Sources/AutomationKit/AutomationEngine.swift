import Combine
import Foundation
import WebKit

/// A lightweight automation engine that coordinates scripted page actions.
final class AutomationEngine: ObservableObject {
    enum State: Equatable {
        case idle
        case running(action: String)
        case completed(action: String, success: Bool)
    }

    @Published private(set) var state: State = .idle

    private let webView: WKWebView
    private var cancellables = Set<AnyCancellable>()

    init(webView: WKWebView) {
        self.webView = webView
    }

    func perform(action: SiteAction) {
        state = .running(action: action.identifier)
        let js = action.javascript

        webView.evaluateJavaScript(js) { [weak self] result, error in
            guard let self else { return }

            if let error {
                NSLog("Automation action failed: \(error)")
                self.state = .completed(action: action.identifier, success: false)
                return
            }

            if let boolResult = result as? Bool {
                self.state = .completed(action: action.identifier, success: boolResult)
            } else {
                self.state = .completed(action: action.identifier, success: true)
            }
        }
    }
}
