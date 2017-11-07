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
    
    // MARK: - Utils
    
    // MARK: - IBActions
    @IBAction func humanVsBotButtonDidTouchUpInside(_ sender: Any) {
        // TODO: launch a game with a human vs bot mode
    }
    
    @IBAction func botVsBotButtonDidTouchUpInside(_ sender: Any) {
        // TODO: launch a game with a bot vs bot mode
    }
}
