//
// Copyright © 2022 An Tran. All rights reserved.
//

import Alamofire
import Combine
import LocalConsole
import Logging
import Pulse
import PulseUI
import SwiftUI
import UIKit

final class ViewController: UIViewController {
    
    private lazy var networkLogger = NetworkLogger()
    var session: Session!

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        let instructionLabel = UILabel()
        instructionLabel.text = "Swipe from the right edge to open the Debug Menu"
        instructionLabel.textAlignment = .center
        instructionLabel.numberOfLines = 0
        instructionLabel.font = .systemFont(ofSize: 12)
        
        let button = UIButton()
        button.setTitleColor(.tintColor, for: .normal)
        button.setTitle("Trigger Network", for: .normal)
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)

        let pulseButton = UIButton()
        pulseButton.setTitleColor(.tintColor, for: .normal)
        pulseButton.setTitle("Show Pulse UI", for: .normal)
        pulseButton.addTarget(self, action: #selector(self.didTapPulseButton), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [instructionLabel, button, pulseButton])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: stackView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
        ])

        let networkMonitor = NetworkLoggerEventMonitor(logger: networkLogger)
        session = Session(eventMonitors: [networkMonitor])
    }
    
    @objc func didTapButton() {
        session.request("https://httpbin.org/get").responseString { response in
            print(response)
        }
    }

    @objc func didTapPulseButton() {
        present(UIHostingController(rootView: MainView()), animated: true)
    }
}
