//
//  GameViewController.swift
//  rps
//
//  Created by Robin on 07/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewModelDelegate {
    // MARK: - IBOutlets
    @IBOutlet weak var firstUserNameLabel: UILabel!
    @IBOutlet weak var firstUserScoreLabel: UILabel!
    @IBOutlet weak var firstUserNextAttackLabel: UILabel!
    @IBOutlet weak var firstUserTrophyLabel: UILabel!
    @IBOutlet weak var secondUserNameLabel: UILabel!
    @IBOutlet weak var secondUserScoreLabel: UILabel!
    @IBOutlet weak var secondUserNextAttackLabel: UILabel!
    @IBOutlet weak var secondUserTrophyLabel: UILabel!
    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var attacksStackView: UIStackView!
    
    // MARK: - Variables
    var gameViewModel: GameViewModel?

    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = gameViewModel {
            viewModel.delegate = self
        }
        
        // Clear the UI to prepare the game
        resetUIAfterOneRound()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // If there is no current game when the UIViewController appear, return to the home
        if gameViewModel == nil {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Configuration
    
    fileprivate func refreshUI() {
        guard let viewModel = gameViewModel else {
            print("GameViewController - refreshUI(): Can't refresh the UI without a GameViewModel set")
            return
        }
        
        firstUserNameLabel.text = viewModel.firstUser.type.emoji()
        secondUserNameLabel.text = viewModel.secondUser.type.emoji()
        firstUserScoreLabel.text = viewModel.scoreSentenceFor(viewModel.firstUser)
        secondUserScoreLabel.text = viewModel.scoreSentenceFor(viewModel.secondUser)
    }
    
    fileprivate func resetUIAfterOneRound() {
        firstUserNextAttackLabel.text = NSLocalizedString("game.unset", comment: "Unset attack")
        secondUserNextAttackLabel.text = NSLocalizedString("game.unset", comment: "Unset attack")
        firstUserTrophyLabel.isHidden = true
        secondUserTrophyLabel.isHidden = true
        
        refreshUI()
    }
    
    // MARK: - Utils
    
    fileprivate func displayUsersAttack() {
        firstUserNextAttackLabel.text = gameViewModel?.firstUser.nextAttack?.emoji()
        secondUserNextAttackLabel.text = gameViewModel?.secondUser.nextAttack?.emoji()
    }
    
    // MARK: - IBActions
    
    @IBAction func attackButtonDidTouchUpInside(_ sender: UIButton) {
        guard let viewModel = gameViewModel else { return }
        
        switch sender {
        case rockButton:
            viewModel.userDidPlay(.rock)
            break
        case paperButton:
            viewModel.userDidPlay(.paper)
            break
        case scissorsButton:
            viewModel.userDidPlay(.scissors)
            break
        default:
            fatalError("GameViewController - attackButtonDidTouchUpInside(): Wrong sender")
        }
    }
    
    // MARK: - GameViewModelDelegate
    
    func prepareForTheNextRound() {
        resetUIAfterOneRound()
    }
    
    func userDidWinTheRound(_ player: User) {
        displayUsersAttack()
        refreshUI()
        
        if player === gameViewModel?.firstUser {
            firstUserTrophyLabel.isHidden = false
        } else {
            secondUserTrophyLabel.isHidden = false
        }
    }
    
    func roundFinishedWithAnEquality() {
        displayUsersAttack()
    }
    
    func gameIsOver(_ winner: User) {
        refreshUI()
        
    }
    
    func anErrorHappendDuringTheLastRound(_ error: String) {
        let alert = UIAlertController(title: NSLocalizedString("error.title", comment: "error alert title"),
                                      message: error,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("error.ok", comment: "error alert ok button"),
                                     style: .default) { [weak self] _ in
                                        self?.resetUIAfterOneRound()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
