//
//  ScoreManager.swift
//  MyBrandNewProject
//
//  Created by Joseph on 09/09/2024.
//

import Foundation


class ScoreManager {
 
    var scores: [Player:Int] = [:]
    
    static let singelton : ScoreManager = ScoreManager()
    
    init() {
        resetScores()
    }
    
    func getScore(_ player: Player) -> Int {
        return scores[player] ?? 0
    }
    
    func getPlayer(_ index: Int) -> Player {
        let player = Array(scores.keys)[index]
        return player
    }
    
    func incrementScore(player: Player) {
        if let currentScore = scores[player] {
            scores[player] = currentScore + 1
        }
    }
    
    func resetScores() {
        for player in Player.allCases {
            scores[player] = 0
        }
    }
    
}
