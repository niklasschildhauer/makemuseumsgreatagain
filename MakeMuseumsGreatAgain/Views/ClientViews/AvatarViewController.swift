//
//  AvatarViewController.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 25.11.21.
//

import UIKit
import AVFoundation

protocol AvatarViewing: AnyObject {
    var presenter: AvatarPresenting? { get set }
    
    func test()
}

protocol AvatarPresenting {
    var view: AvatarViewing? { get set }
    func viewDidLoad()
}

class AvatarPresenter: AvatarPresenting {
    weak var view: AvatarViewing?
    
    func viewDidLoad() {
        view?.test()
    }

}

class AvatarViewController: UIViewController {
    
    var presenter: AvatarPresenting? {
        didSet {
            presenter?.view = self
        }
    }
    var player: AVPlayer?
    @IBOutlet weak var videoContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        initializeVideoPlayerWithVideo()
        
        player?.play()
        
        presenter?.viewDidLoad()
    }
    
    func initializeVideoPlayerWithVideo() {
        
        // get the path string for the video from assets
        let videoString:String? = Bundle.main.path(forResource: "testVideo", ofType: "mp4")
        guard let unwrappedVideoPath = videoString else {return}
        
        // convert the path string to a url
        let videoUrl = URL(fileURLWithPath: unwrappedVideoPath)
        
        // initialize the video player with the url
        self.player = AVPlayer(url: videoUrl)
        
        // create a video layer for the player
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        
        // make the layer the same size as the container view
        layer.frame = videoContainer.bounds
        
        // make the video fill the layer as much as possible while keeping its aspect size
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        // add the layer to the container view
        videoContainer.layer.addSublayer(layer)
    }
    
}

extension AvatarViewController: StoryboardInitializable { }

extension AvatarViewController: AvatarViewing {
    func test() {
        view.backgroundColor = .yellow
    }

}
