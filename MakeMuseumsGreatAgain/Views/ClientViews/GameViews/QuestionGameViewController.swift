//
//  QuestionGameViewController.swift
//  MakeMuseumsGreatAgain
//
//  Created by Niklas Schildhauer on 15.12.21.
//

import UIKit

protocol QuestionGameViewing: AnyObject {
    var presenter: QuestionGamePresenting! { get set }
    
    func display(text: String)
}

protocol QuestionGamePresenting {
    var view: QuestionGameViewing? { get set }
    var numberOfAnswers: Int { get }
    
    func configure(answer: QuestionAnswerViewing, at index: Int)
    func didTapAnswer(at index: Int)
    func viewDidLoad()
}

protocol QuestionAnswerViewing {
    func display(text: String)
}

class QuestionGamePresenter: QuestionGamePresenting {
    weak var view: QuestionGameViewing?
    
    private let question: Question
    
    var numberOfAnswers: Int {
        question.answers.count
    }
    
    init(question: Question) {
        self.question = question
    }
    
    func viewDidLoad() {
        view?.display(text: question.text)
    }
    
    func configure(answer: QuestionAnswerViewing, at index: Int) {
        answer.display(text: question.answers[index].text)
    }
    
    func didTapAnswer(at index: Int) {
        print("did tap answer")
    }
}

class QuestionGameViewController: UIViewController {
    
    var presenter: QuestionGamePresenting! {
        didSet {
            presenter.view = self
        }
    }
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        text.numberOfLines = 0
        
        presenter.viewDidLoad()
    }
}

extension QuestionGameViewController: StoryboardInitializable { }

extension QuestionGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfAnswers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionAnswerCollectionView", for: indexPath) as! QuestionAnswerCollectionView
        
        cell.blurBackground(behind: cell.background)
        cell.background.layer.cornerRadius = Constants.cornerRadius
        cell.background.clipsToBounds = true
        
        presenter.configure(answer: cell, at: indexPath.row)
                        
        return cell
    }
}

// MARK: - Collection View Flow Layout Delegate
extension QuestionGameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding = 15.0
        
        let availableWidth = collectionView.frame.width
        let widthPerItem = availableWidth / 2 - padding
        
        let availableHeight = collectionView.frame.height
        let heightPerItem = availableHeight / 2 - padding
        
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 30
    }
}


extension QuestionGameViewController: QuestionGameViewing {
    func display(text: String) {
        self.text.text = text
    }
}

class QuestionAnswerCollectionView: UICollectionViewCell, QuestionAnswerViewing {
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var background: UIView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func display(text: String) {
        self.text.text = text
    }
}
