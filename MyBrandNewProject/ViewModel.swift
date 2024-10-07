//
//  ViewModel.swift
//  MyBrandNewProject
//
//  Created by Joseph on 22/08/2024.
//

import Foundation

// TODO: implement a score as well, keep track of how many times
// players 1 and 2 won

class ViewModel: ObservableObject {
    
    let cols = 7;
    let rows = 7;
    
    @Published var board:[[Position]] = [];
    var turn: Player = .player1;
    var winCheckManager: WinCheckManager = WinCheckManager();
    
    let scoreManager = ScoreManager()
    
    init() {
        self.initialiseBoard()
    }
    
    func changeTurn() {
        self.turn = self.turn == .player1 ? .player2 : .player1;
    }
    
    func takePositionConnect4Style(_ position: Position) -> Position? {
        
        let col = position.col
        
        for index in 0...(board.count-1) {
            
            let row = board.count - 1 - index
            
            if self.board[row][col].marked == nil {
                
                let newPosition = Position(row: row, col: col)
                newPosition.marked = self.turn;
                
                self.board[row][col] = newPosition
                return newPosition
            }
            
        }
        
        return nil
    }
    
    func takePositionTikTakToeStyle(_ position: Position) {
        var newPosition = Position(row: position.row, col: position.col)
        newPosition.marked = self.turn;
        
        self.board[position.row][position.col] = newPosition
    }
    
    
    // TODO: doesn't make sense to pass the parameter here
    func markPosition(position: Position, callback: (Bool) -> Void) {
        
        guard position.marked == nil else { return }
        
        if let positionPlaced = takePositionConnect4Style(position) {
            
            winCheckManager.turn = self.turn
            winCheckManager.board = self.board
            
            // now we can allow the player to play tik tak toe or connect 4
            if self.winCheckManager.checkForWin(positionPlaced) {
//                print("GAME OVER Player \(self.turn) won the game!")
                callback(true);
                ScoreManager.singelton.incrementScore(player: self.turn)
                return
            }
            
            changeTurn();
        }
    }
    
    func initialiseBoard() {
        
        // TODO: can I initialise this with correct positions all at once ?
        let columns = Array(repeating: Position(row: 0, col: 0), count: cols)
        let emptyRows: [[Position]] = Array(repeating: columns, count: rows)
        board = emptyRows;

        for row in 0..<rows {
            for col in 0..<cols {
                board[row][col] = Position(row: row, col: col)
            }
        }
        
        self.turn = .player1;
    }
    
    
}
