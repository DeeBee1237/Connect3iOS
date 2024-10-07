//
//  Position.swift
//  MyBrandNewProject
//
//  Created by Joseph on 06/09/2024.
//

import Foundation


class Position: Identifiable {
    
    let row: Int;
    let col: Int;
    var marked: Player?
    
    init(row: Int, col: Int) {
        self.row = row;
        self.col = col;
    }
    
}
