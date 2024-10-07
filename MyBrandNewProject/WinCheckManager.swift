//
//  WinCheckManager.swift
//  MyBrandNewProject
//
//  Created by Joseph on 06/09/2024.
//

import Foundation
import UIKit


class WinCheckManager {
    
    var board:[[Position]] = [];
    var turn: Player = .player1;
    
    // can configure this
    let toConnect = 3;
    
//    init(board: [[Position]], turn: Player) {
//        self.board = board
//        self.turn = turn
//    }
    
    func checkForWinHorizontal1(_ position: Position) -> Bool {
        
        for col in (position.col-1)...(position.col+1) {
            
            // bounds check for col
            guard col >= 0 && col < self.board[position.row].count else { return false }
            
            if self.board[position.row][col].marked != self.turn {
                return false
            }
            
        }
        
        return true
    }
    
    func checkForWinHorizontal2(_ position: Position) -> Bool {
        
        for col in (position.col)...(position.col+2) {
            
            // bounds check for col
            guard col >= 0 && col < self.board[position.row].count else { return false }
            
            if self.board[position.row][col].marked != self.turn {
                return false
            }
            
        }
        
        return true
    }
    
    func checkForWinHorizontal3(_ position: Position) -> Bool {
        
        for col in (position.col-2)...(position.col) {
            
            // bounds check for col
            guard col >= 0 && col < self.board[position.row].count else { return false }
            
            if self.board[position.row][col].marked != self.turn {
                return false
            }
            
        }
        
        return true
    }
    
    func checkForWinHorizontal(_ position: Position) -> Bool {
        
        return checkForWinHorizontal1(position)
        || checkForWinHorizontal2(position)
        || checkForWinHorizontal3(position)
       
    }
    
    
    // this logic may need to chan ge depednding on connect 4 or tic tac toe style
    func checkForWinVertical(_ position: Position) -> Bool {
        
        for row in (position.row)...(position.row+2) {
            
            guard row >= 0 && row < self.board.count else { return false }
            
            if self.board[row][position.col].marked != self.turn {
                return false
            }
            
        }
        
        return true
    }
    
    func checkForWinDiagonal1(_ position: Position) -> Bool {
        
        for index in 0..<3 {
            
            let checkRow = position.row - index
            let checkCol = position.col - index
            
            guard checkRow >= 0 && checkRow < board.count // shouldnt need this here but safe anyway
                    && checkCol >= 0 && checkCol < board[checkRow].count else {
                return false
            }
                        
            if board[checkRow][checkCol].marked != turn {
                return false
            }
            
        }
        
        return true
    }
    
    func checkForWinDiagonal2(_ position: Position) -> Bool {
        
        for index in 0..<3 {
            
            let checkRow = position.row + index
            let checkCol = position.col - index
            
            guard checkRow >= 0 && checkRow < board.count // shouldnt need this here but safe anyway
                    && checkCol >= 0 && checkCol < board[checkRow].count else {
                return false
            }
                        
            if board[checkRow][checkCol].marked != turn {
                return false
            }
            
        }
        
        return true
    }
    
    func checkForWinDiagonal3(_ position: Position) -> Bool {
        
        for index in 0..<3 {
            
            let checkRow = position.row - index
            let checkCol = position.col + index
            
            guard checkRow >= 0 && checkRow < board.count // shouldnt need this here but safe anyway
                    && checkCol >= 0 && checkCol < board[checkRow].count else {
                return false
            }
                        
            if board[checkRow][checkCol].marked != turn {
                return false
            }
            
        }
        
        return true
    }
    
    func checkForWinDiagonal4(_ position: Position) -> Bool {
        
        for index in 0..<3 {
            
            let checkRow = position.row + index
            let checkCol = position.col + index
            
            guard checkRow >= 0 && checkRow < board.count // shouldnt need this here but safe anyway
                    && checkCol >= 0 && checkCol < board[checkRow].count else {
                return false
            }
                        
            if board[checkRow][checkCol].marked != turn {
                return false
            }
            
        }
        
        return true
    }
    
    func checkForWinDiagonal(_ position: Position) -> Bool {
        
        // TODO: need checks 5 and 6 to handle the case where the token is placed in between two existing tokens
        
        
        return checkForWinDiagonal1(position)
        
        || checkForWinDiagonal2(position)
        
        || checkForWinDiagonal3(position)
        
        || checkForWinDiagonal4(position)
        
        || checkForWinDiagonal2(Position(row: position.row - 1, col:  position.col + 1))
        
        || checkForWinDiagonal4(Position(row: position.row - 1, col:  position.col - 1))
        
    }
    
    /**
          check the position where the token landed and see if they have 3/4/n connected tokens relative to that position
     */
    func checkForWin(_ position: Position) -> Bool {
                
        if (checkForWinHorizontal(position)) {
            return true
        } else if (checkForWinVertical(position)) {
            return true
        } else if (checkForWinDiagonal(position)) {
            return true
        }
        
        return false
        
    }
    
}
