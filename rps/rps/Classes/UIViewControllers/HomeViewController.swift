//
//  HomeViewController.swift
//  rps
//
//  Created by Robin on 07/11/2017.
//  Copyright © 2017 Robin Authiat. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gameModeLabel: UILabel!
    @IBOutlet weak var humanVsBotButton: UIButton!
    @IBOutlet weak var botVsBotButton: UIButton!
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshUI()
    }
    
    // MARK: - Configuration
    
    fileprivate func refreshUI() {
        emojiLabel.text = NSLocalizedString("home.emojis_title", comment: "Emojis title")
        titleLabel.text = NSLocalizedString("home.title", comment: "rock, paper, scissors")
        gameModeLabel.text = NSLocalizedString("home.game_mode", comment: "Game modes")
        humanVsBotButton.setTitle(NSLocalizedString("home.human_vs_bot", comment: "human vs bot"), for: .normal)
        botVsBotButton.setTitle(NSLocalizedString("home.bot_vs_bot", comment: "bot vs bot"), for: .normal)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHumanVsBotGameViewControllerSegue", let vc = segue.destination as? GameViewController {
            let human = User(.human)
            let bot = User(.bot)
            if let game = GamePlay(players: [ human, bot ]), let viewModel = GameViewModel(game: game) {
                vc.gameViewModel = viewModel
            }
        } else if segue.identifier == "showBotVsBotGameViewControllerSegue", let vc = segue.destination as? GameViewController {
            let botOne = User(.bot)
            let botTwo = User(.bot)
            if let game = GamePlay(players: [ botOne, botTwo ]), let viewModel = GameViewModel(game: game) {
                vc.gameViewModel = viewModel
            }
        }
    }
}
