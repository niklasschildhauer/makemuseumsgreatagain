//
//  ClientCoordinator.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 23.11.21.
//

import Foundation
import UIKit

protocol ClientCoordinatorDelegate {
    
}

protocol ClientCoordinatorProtocol {
    var delegate: ClientCoordinatorDelegate? { get set }
    
    func handle(event: Event)
}

class ClientCoordinator: Coordinator {
    var rootViewController: UIViewController = UIViewController()
    
    var delegate: ClientCoordinatorDelegate?
    
    init() {
        rootViewController = createClientViewController()
    }
    
    private func createClientViewController() -> UIViewController {
        let clientViewController = ClientViewController.makeFromStoryboard()
        let clientPresenter = ClientPresenter()
        
        clientViewController.presenter = clientPresenter
        clientPresenter.delegate = self
        
        return clientViewController
    }
    
    private func showGameViewController() {
        let gameView = GameViewController.makeFromStoryboard()
        
        DispatchQueue.main.async {
            self.rootViewController.present(gameView, animated: true)
        }
    }
}

extension ClientCoordinator: ClientCoordinatorProtocol {
    
    public func handle(event: Event) {
        switch event {
        case .showGame:
            showGameViewController()
        case .read(let message):
            print("read Message \(message)")
        }
    }
    
}

extension ClientCoordinator: ClientPresenterDelegate {
    
}
