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
    @IBOutlet weak var spockButton: UIButton!
    @IBOutlet weak var lizardButton: UIButton!
    @IBOutlet weak var nextRoundButton: UIButton!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // If there is no current game when the UIViewController appear, return to the home
        if gameViewModel == nil {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    // MARK: - Configuration
    
    fileprivate func configUI() {
        guard let viewModel = gameViewModel else {
            print("GameViewController - configUI(): Can't refresh the UI without a GameViewModel set")
            return
        }
        
        firstUserNameLabel.text = viewModel.nameSentenceFor(viewModel.userPlayer, info: NSLocalizedString("game.you", comment: "You (represent the player)"))
        secondUserNameLabel.text = viewModel.nameSentenceFor(viewModel.botPlayer, info: NSLocalizedString("game.opponent", comment: "Opponent"))
        nextRoundButton.setTitle(NSLocalizedString("game.next_round", comment: "Next round"), for: .normal)
    }
    
    fileprivate func refreshUI() {
        guard let viewModel = gameViewModel else {
            print("GameViewController - refreshUI(): Can't refresh the UI without a GameViewModel set")
            return
        }
        
        firstUserScoreLabel.text = viewModel.scoreSentenceFor(viewModel.userPlayer)
        secondUserScoreLabel.text = viewModel.scoreSentenceFor(viewModel.botPlayer)
    }
    
    fileprivate func resetUIAfterOneRound() {
        firstUserNextAttackLabel.text = NSLocalizedString("game.unset", comment: "Unset attack")
        secondUserNextAttackLabel.text = NSLocalizedString("game.unset", comment: "Unset attack")
        firstUserTrophyLabel.isHidden = true
        secondUserTrophyLabel.isHidden = true
        
        if let viewModel = gameViewModel, viewModel.isBotVsBot {
            nextRoundButton.isHidden = false
            attacksStackView.isHidden = true
        } else {
            nextRoundButton.isHidden = true
        }
        
        refreshUI()
    }
    
    // MARK: - Utils
    
    fileprivate func displayUsersAttack() {
        firstUserNextAttackLabel.text = gameViewModel?.userPlayer.nextAttack?.emoji()
        secondUserNextAttackLabel.text = gameViewModel?.botPlayer.nextAttack?.emoji()
    }
    
    fileprivate func animateTrophy(of winner: User) {
        let labelToAnimate = (winner === gameViewModel?.userPlayer) ? firstUserTrophyLabel : secondUserTrophyLabel
        labelToAnimate?.alpha = 0.0
        labelToAnimate?.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: {
            labelToAnimate?.alpha = 1.0
        }) { [weak self] completed in
            if completed, let viewModel = self?.gameViewModel {
                self?.nextRoundButton.isHidden = viewModel.game.isOver()
            }
        }
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
        case spockButton:
            viewModel.userDidPlay(.spock)
            break
        case lizardButton:
            viewModel.userDidPlay(.lizard)
            break
        default:
            fatalError("GameViewController - attackButtonDidTouchUpInside(): Wrong sender")
        }
        
        attacksStackView.isUserInteractionEnabled = false
    }
    
    @IBAction func nextRoundDidTouchUpInside(_ sender: Any) {
        resetUIAfterOneRound()
        attacksStackView.isUserInteractionEnabled = true
        
        if let viewModel = gameViewModel, viewModel.isBotVsBot {
            viewModel.startBotVsBotRound()
        }
    }
    
    // MARK: - GameViewModelDelegate
    
    func prepareForTheNextRound() {
        resetUIAfterOneRound()
    }
    
    func userDidWinTheRound(_ player: User) {
        displayUsersAttack()
        refreshUI()
        
        animateTrophy(of: player)
    }
    
    func roundFinishedWithAnEquality() {
        displayUsersAttack()
        nextRoundButton.isHidden = false
    }
    
    func gameIsOver(_ didWin: Bool) {
        refreshUI()
        
        let alertTitle = didWin ? NSLocalizedString("game.winner.title", comment: "Winner alert title") : NSLocalizedString("game.looser.title", comment: "Looser alert title")
        let alertMessage = didWin ? NSLocalizedString("game.winner.message", comment: "Winner alert message") : NSLocalizedString("game.looser.message", comment: "Looser alert message")
        let alertOk = didWin ? NSLocalizedString("game.winner.ok", comment: "Winner alert ok button") : NSLocalizedString("game.looser.ok", comment: "Looser alert ok button")
    
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: alertOk,
                                     style: .default) { [weak self] _ in
                                        self?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
