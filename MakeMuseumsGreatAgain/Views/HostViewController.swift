//
//  HostViewController.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 19.11.21.
//

import UIKit

protocol HostPresenting {
    var view: HostViewing? { get set }
}

protocol HostViewing: AnyObject {

}

class HostViewController: UIViewController {
    
    var presenter: HostPresenting! {
        didSet {
            presenter.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
    var view: HostViewing?

}
