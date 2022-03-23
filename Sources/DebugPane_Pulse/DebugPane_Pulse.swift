//
// Copyright © 2021 An Tran. All rights reserved.
//

import Combine
import Foundation
import Pulse
import PulseUI
import SwiftUI
import TweakPane
import UIKit

public struct PulseBlade: Blade {
    public var name: String? = "Pulse"
    
    private var presentingViewController: () -> UIViewController?
    
    public init(presentingViewController: @escaping () -> UIViewController?) {
        self.presentingViewController = presentingViewController
    }
    
    public func render() -> AnyView {
        AnyView(ContentView(action: { presentingViewController()?.present($0, animated: true) }))
    }
}

private struct ContentView: View {
    var action: (UIViewController) -> Void
    var body: some View {
        VStack {
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
}
