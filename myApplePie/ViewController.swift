//
//  ViewController.swift
//  myApplePie
//
//  Created by Valentin Caure on 19/01/2023.
//

import UIKit

class ViewController: UIViewController {

    var list_of_word: [String] = ["téléphone", "buccaneer", "swift", "glorious", "incadescent", "bug", "program"]
    
    let incorrect_moves_allowed: Int = 7
    
    var total_wins = 0 {
        didSet {
            newRound()
        }
    }
    
    var total_loses = 0 {
        didSet {
            newRound()
        }
    }
    
    var total_score = 0
    
    @IBOutlet var treeImageView: UIImageView!

    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var current_game: Game!

    fileprivate func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func newRound() {
        let new_word = list_of_word.removeFirst()

        if (list_of_word.isEmpty) {
            enableLetterButtons(false)
            return
        }
        current_game = Game(word: new_word, incorrect_moves_remaining: incorrect_moves_allowed, guessed_letters: [])
        enableLetterButtons(true)
        updateUI()
    }
    
    func updateUI() {
        scoreLabel.text = "Wins: \(total_wins), Losses: \(total_loses), Score: \(total_score)"
        correctWordLabel.text = current_game.formatted_word.map { "\($0)" }.joined(separator: " ")
        treeImageView.image = UIImage(named: "Tree \(current_game.incorrect_moves_remaining)")
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let button_pressed: String = sender.configuration!.title!
        let letter: Character = Character(button_pressed.lowercased())

        if (current_game.playerGuessed(letter: letter)) {
            total_score += 1
        }
        updateGameState()
    }
    
    func updateGameState() {
        if (current_game.incorrect_moves_remaining <= 0) {
            total_loses += 1
            total_score += current_game.word.count
        } else if (!current_game.formatted_word.contains("_")){
            total_wins += 1
        } else {
            updateUI()
        }
    }

}

