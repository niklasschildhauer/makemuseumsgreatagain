//
//  GameCoordinator.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 15.12.21.
//

import Foundation
import UIKit

protocol GameCoordinatorDelegate {
    
}

protocol GameCoordinatorProtocol {
    var delegate: GameCoordinatorDelegate? { get set }
    
    func handle(gameEvent: GameEvent)
}

class GameCoordinator: Coordinator {
    var rootViewController: UIViewController {
        navigationController
    }
    
    private var navigationController = UINavigationController()
        
    var delegate: GameCoordinatorDelegate?
    
    init() {
    }
    
    private func showQuestionViewController(with question: Question) {
        let view = QuestionGameViewController.makeFromStoryboard()
        let presenter = QuestionGamePresenter(question: question)
        
        view.presenter = presenter
        
        self.navigationController.setViewControllers([view], animated: true)
        
    }
}

extension GameCoordinator: GameCoordinatorProtocol {
    func handle(gameEvent: GameEvent) {
        switch gameEvent {
        case .question(let question):
            showQuestionViewController(with: question)
        }
    }
    
    
}

extension GameCoordinator: GameCoordinatorDelegate {
    
}

