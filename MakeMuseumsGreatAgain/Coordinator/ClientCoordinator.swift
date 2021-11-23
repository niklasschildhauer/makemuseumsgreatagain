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
    
}

extension ClientCoordinator: ClientPresenterDelegate {
    
}
