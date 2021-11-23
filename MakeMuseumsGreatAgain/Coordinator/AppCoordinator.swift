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
    private let connectionManager: ConnectionManager
    
    init(window: UIWindow) {
        self.window = window
        
        let manager = ConnectionManager()
        self.connectionManager = manager
        manager.delegate = self
        
        showMainViewController()
    }
    
    private func showMainViewController() {
        let mainView = MainViewController.makeFromStoryboard()
        let mainPresenter = MainPresenter(connectionManager: connectionManager)
        
        mainView.presenter = mainPresenter
        mainPresenter.delegate = self
        
        rootViewController = mainView
    }
    
    private func showHostViewController() {
        let hostView = HostViewController.makeFromStoryboard()
        let hostPresenter = HostPresenter()
        
        hostView.presenter = hostPresenter
        hostPresenter.delegate = self
        DispatchQueue.main.async {
            self.rootViewController.present(hostView, animated: true)
        }
    }
    
    private func showClientCoordinator() {
        let clientCoordinator = ClientCoordinator()
        
        clientCoordinator.delegate = self
        
        DispatchQueue.main.async {
            self.rootViewController.present(clientCoordinator.rootViewController, animated: true)
        }
    }
}

extension AppCoordinator: ClientCoordinatorDelegate {
    
}

extension AppCoordinator: HostPresenterDelegate {
    
}

extension AppCoordinator: MainPresenterDelegate {

}

extension AppCoordinator: ConnectionManagerDelegate {
    func didJoinSession(in: ConnectionManager) {
        showClientCoordinator()
    }
    
    func didHostSession(in: ConnectionManager) {
        showHostViewController()
    }
}