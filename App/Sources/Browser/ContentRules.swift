import Foundation
import WebKit

enum ContentRules {
    static func compile(from bundle: Bundle = .main, completion: @escaping (WKContentRuleList?) -> Void) {
        guard let url = bundle.url(forResource: "ContentBlocker", withExtension: "json"),
              let json = try? String(contentsOf: url) else {
            completion(nil)
            return
        }

        WKContentRuleListStore.default().compileContentRuleList(forIdentifier: "aishopper.rules", encodedContentRuleList: json) { list, error in
            if let error {
                NSLog("Content rule compilation failed: \(error)")
                completion(nil)
                return
            }

            completion(list)
        }
    }
}
