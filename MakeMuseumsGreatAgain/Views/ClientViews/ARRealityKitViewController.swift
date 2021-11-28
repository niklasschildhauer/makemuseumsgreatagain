//
//  ARRealityKitViewController.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 26.11.21.
//

import UIKit
import RealityKit

class ARRealityKitViewController: UIViewController {

    @IBOutlet weak var scene: ARView!
    var anchor: Engine.EngineModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nur zum testen! Try Block entfernen
        anchor = try! Engine.loadEngineModel()
        
        scene.scene.anchors.append(anchor)
        
    }
}

extension ARRealityKitViewController: StoryboardInitializable { }
