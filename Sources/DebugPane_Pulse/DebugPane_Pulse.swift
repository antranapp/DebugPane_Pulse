import Combine
import Foundation
import Pulse
import SwiftUI
import TweakPane
import UIKit
import PulseUI

public struct PulseBlade: Blade {
    public var name: String = "Pulse"
    
    private weak var presentingViewController: UIViewController?
    
    public init(_ presentingViewController: UIViewController?) {
        self.presentingViewController = presentingViewController
    }
    
    public func render() -> AnyView {
        AnyView(ContentView(action: {presentingViewController?.present($0, animated: true)} ))
    }
}

private struct ContentView: View {
    var action: (UIViewController) -> Void
    var body: some View {
        Button(
            action: {
                action(UIHostingController(rootView: MainView()))
            },
            label: {
                Text("Show Pulse")
            }
        )
    }
}
