//
//  ViewController.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 19.11.21.
//

import UIKit

protocol MainPresenting {
    var view: MainViewing? { get set }
    func join()
    func host()
}

protocol MainViewing: AnyObject {
    func show(hostScreen: UIViewController)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var hostButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    var presenter: MainPresenting? {
        didSet {
            presenter?.view = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapJoin(_ sender: Any) {
        presenter?.join()
    }
    
    @IBAction func didTapHost(_ sender: Any) {
        presenter?.host()
    }
    
}

extension MainViewController: StoryboardInitializable { }

extension MainViewController: MainViewing {
    
    func show(hostScreen: UIViewController) {
        present(hostScreen, animated: true)
    }
}

class MainPresenter: MainPresenting {
    
    let connectionManager = ConnectionManager()
    weak var view: MainViewing?
    
    init() {
    }
    
    func join() {
        connectionManager.join()
    }
    
    func host() {
        connectionManager.host {
            // Hier sollte ein Delegate aufruf des Coordinators rein! Wichtig: Coordinator muss implementiert werden.
            // Der Code darunter muss in einen Coordinator rein!
            let hostView = HostViewController.makeFromStoryboard()
            let hostPresenter = HostPresenter()
            
            hostView.presenter = hostPresenter
            
            view?.show(hostScreen: hostView)
        }
    }

}



