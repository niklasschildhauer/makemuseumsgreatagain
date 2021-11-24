//
//  HostViewController.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 19.11.21.
//

import UIKit

protocol HostPresenterDelegate { }

protocol HostPresenting {
    var view: HostViewing? { get set }
    var delegate: HostPresenterDelegate? { get set }
    
    func viewDidLoad()
    func showGame()
}

protocol HostViewing: AnyObject {
    var presenter: HostPresenting! { get set }
    
}

class HostViewController: UIViewController {
    
    var presenter: HostPresenting! {
        didSet {
            presenter.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    @IBAction func showGame(_ sender: Any) {
        presenter.showGame()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HostViewController: StoryboardInitializable { }

extension HostViewController: HostViewing {
}

class HostPresenter: HostPresenting {
    var delegate: HostPresenterDelegate?
    
    weak var view: HostViewing?
    
    private let connectionManager: ConnectionManager
    
    init(connectionManager: ConnectionManager) {
        self.connectionManager = connectionManager
    }

    func viewDidLoad() {
        
    }
    
    func showGame() {
        let event = Event.showGame
        connectionManager.send(event)
    }
}
