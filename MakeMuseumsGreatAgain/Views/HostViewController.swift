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
    func showARCamera()
    func showAvatar()
    func reloadAvatar()
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
    
    @IBAction func reloadAvatar(_ sender: Any) {
        presenter.reloadAvatar()
    }
    
    @IBAction func showGame(_ sender: Any) {
        presenter.showGame()
    }
    
    
    @IBAction func showARCamera(_ sender: Any) {
        presenter.showARCamera()
    }
    
    @IBAction func showAvatar(_ sender: Any) {
        presenter.showAvatar()
    }
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
        let answer1 = Answer(text: "1980", isTrue: false)
        let answer2 = Answer(text: "1900", isTrue: false)
        let answer3 = Answer(text: "1908", isTrue: true)
        let answer4 = Answer(text: "1850", isTrue: false)

        let question = Question(text: "Wann wurde Mercedes Benz gegründet", answers: [answer1, answer2, answer3, answer4])
        let event = Event.showGame(gameEvent: .question(question))
        connectionManager.send(event)
    }
    
    func showARCamera() {
        let event = Event.showARCamera
        connectionManager.send(event)
    }
    
    func showAvatar() {
        let event = Event.showAvatar
        connectionManager.send(event)
    }
    
    func reloadAvatar() {
        let event = Event.reloadAvatar
        connectionManager.send(event)
    }
}
