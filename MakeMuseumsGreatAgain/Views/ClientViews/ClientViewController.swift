//
//  ClientViewController.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 19.11.21.
//

import UIKit

protocol ClientPresenterDelegate {
    
}

protocol ClientPresenting {
    var view: ClientViewing? { get set }
    var delegate: ClientPresenterDelegate? { get set }
    
    func viewDidLoad()
}

protocol ClientViewing: AnyObject {
    var presenter: ClientPresenting! { get set }
    
    func show(viewController: UIViewController)
    func expandAvatar()
    func shrinkAvatar()
}

class ClientViewController: UIViewController {
        
    var presenter: ClientPresenting! {
        didSet {
            presenter.view = self
        }
    }
    
    @IBOutlet var avatarContainerView: UIView!
    private var avatarViewController: AvatarViewing?
    private var navigationViewController: UINavigationController?
    
    private var isAvatarExpanded = false
    
    @IBOutlet var avatarWrapperView: UIView!
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var leadingConstraint: NSLayoutConstraint!
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var trailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let avatarPresenter = AvatarPresenter()
        avatarViewController?.presenter = avatarPresenter
        avatarPresenter.viewDidLoad()
        
        navigationViewController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Navigation Controller" {
            if let navigationController = segue.destination as? UINavigationController {
                self.navigationViewController = navigationController
            }
        }
        
        if segue.identifier == "Avatar View Controller" {
            if let avatarViewController = segue.destination as? AvatarViewController {
                self.avatarViewController = avatarViewController
            }
        }
    }
}

extension ClientViewController: StoryboardInitializable { }

extension ClientViewController: ClientViewing {
    func expandAvatar() {
        if !isAvatarExpanded {
                self.heightConstraint.isActive = false
                self.widthConstraint.isActive = false
                self.leadingConstraint.isActive = true
                self.topConstraint.isActive = true
                
                self.trailingConstraint.constant = 0
                self.bottomConstraint.constant = 0
            
            UIView.animate(withDuration: 0.5) {
                self.avatarWrapperView.layoutIfNeeded()
            } completion: { _ in
                // Make sure, that the AR Camera is closed
                self.show(viewController: UIViewController())
            }

            self.isAvatarExpanded = true

        }
    }
    
    func shrinkAvatar() {
        if isAvatarExpanded {
            self.leadingConstraint.isActive = false
            self.topConstraint.isActive = false
                self.heightConstraint.isActive = true
                self.widthConstraint.isActive = true
                
                self.trailingConstraint.constant = 20
                self.bottomConstraint.constant = 20
            
            UIView.animate(withDuration: 0.5) {
                self.avatarWrapperView.layoutIfNeeded()
            }
                
            self.isAvatarExpanded = false

        }
    }
    
    func show(viewController: UIViewController) {
        UIView.performWithoutAnimation {
            self.navigationViewController?.setViewControllers([viewController], animated: false)
        }
    }
}


class ClientPresenter: ClientPresenting {
    var delegate: ClientPresenterDelegate?
    
    weak var view: ClientViewing?
    
    func viewDidLoad() {
        
    }

}
