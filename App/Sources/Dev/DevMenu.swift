import SwiftUI

struct DevMenu: View {
    var body: some View {
        List {
            Section("Automation") {
                Button("Run Self-Test") {
                    NotificationCenter.default.post(name: .devMenuSelfTest, object: nil)
                }
            }
            Section("Content") {
                Button("Toggle Content Rules") {
                    NotificationCenter.default.post(name: .devMenuToggleRules, object: nil)
                }
            }
        }
        .navigationTitle("Developer Menu")
    }
}

extension Notification.Name {
    static let devMenuSelfTest = Notification.Name("devMenuSelfTest")
    static let devMenuToggleRules = Notification.Name("devMenuToggleRules")
}

#Preview {
    NavigationView {
        DevMenu()
    }
}
