//
//  Coordinator.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 19.11.21.
//

import Foundation
import UIKit

protocol Coordinator {
    var rootViewController: UIViewController { get }
}

class AppCoordinator: Coordinator {
    var rootViewController: UIViewController = UIViewController() {
        didSet {
            window.rootViewController = rootViewController
            window.makeKeyAndVisible()
        }
    }
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        showMainViewController()
    }

    private func showMainViewController() {
        let mainView = MainViewController.makeFromStoryboard()
        let mainPresenter = MainPresenter()
        
        mainView.presenter = mainPresenter
        
        rootViewController = mainView
    }
}
