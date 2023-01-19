//
//  Game.swift
//  myApplePie
//
//  Created by Valentin Caure on 19/01/2023.
//

import Foundation

struct Game {
    var word: String
    var incorrect_moves_remaining: Int
    var guessed_letters: [Character]
    var formatted_word: [Character] {
        var guessed_word: [Character] = []
        for letter in word {
            let folded_letter = String(letter).folding(options: .diacriticInsensitive, locale: .current)
            if (guessed_letters.contains(folded_letter)) {
                guessed_word.append(letter)
            } else {
                guessed_word.append("_")
            }
        }
        return guessed_word
    }
    
    mutating func playerGuessed(letter: Character) -> Bool {
        guessed_letters.append(letter)
        if (!word.folding(options: .diacriticInsensitive, locale: .current).lowercased().contains(letter)) {
            incorrect_moves_remaining -= 1
            return false
        }
        return true
        
    }
}
