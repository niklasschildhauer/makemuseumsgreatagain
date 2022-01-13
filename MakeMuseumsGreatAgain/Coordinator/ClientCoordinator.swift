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
    var rootViewController: UIViewController {
        get {
            clientView
        }
    }
    
    private var clientView: ClientViewController
    private var gameCoordinator: GameCoordinator = GameCoordinator()
    
    var delegate: ClientCoordinatorDelegate?
    
    init() {
        let clientViewController = ClientViewController.makeFromStoryboard()
        clientView = clientViewController
        let clientPresenter = ClientPresenter()
        
        clientView.modalPresentationStyle = .overFullScreen
        
        clientViewController.presenter = clientPresenter
        clientPresenter.delegate = self
    }
    
    private func showGameViewController(for gameEvent: GameEvent) {
        self.clientView.hideViewController()

        let gameView = self.gameCoordinator.rootViewController
        gameCoordinator.handle(gameEvent: gameEvent)
        
        self.clientView.show(viewController: gameView)
    }
    
    private func showARViewController() {
        self.clientView.hideViewController()

        let arView = ARRealityKitViewController.makeFromStoryboard()
        self.clientView.show(viewController: arView)
    }
    
    private func showAvatarViewController() {
        self.clientView.hideViewController()
    }
    
    private func reloadViews()  {
        self.clientView.reload()
    }
}

extension ClientCoordinator: ClientCoordinatorProtocol {
    
    public func handle(event: Event) {
        DispatchQueue.main.async {
            switch event {
            case .showGame(let gameEvent):
                self.showGameViewController(for: gameEvent)
            case .read(let message):
                print("read Message \(message)")
            case .showARCamera:
                self.showARViewController()
            case .showAvatar:
                self.showAvatarViewController()
            case .reload:
                self.reloadViews()
            case .dismiss:
                self.rootViewController.dismiss(animated: true)
            }
        }
    }
    
}

extension ClientCoordinator: ClientPresenterDelegate {
    
}
