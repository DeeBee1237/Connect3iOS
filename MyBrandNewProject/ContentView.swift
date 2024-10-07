//
//  ContentView.swift
//  MyBrandNewProject
//
//  Created by Joseph on 24/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    // also ensure that this VM instance doesn't get destroyed each time the
    // view re-renders, it is also the creator of the VM
    @StateObject var vm: ViewModel = ViewModel()
    
    @State private var isShowingGameOverSheet: Bool = false
    
    init() {}
    
    var body: some View {
        
        VStack {
            scoreView()
            
            connectGridView()
                .sheet(isPresented: $isShowingGameOverSheet, onDismiss: {
                    isShowingGameOverSheet = false;
                }, content: {
                    
                    Text("\(self.vm.turn.rawValue) won the game")
                    
                    Button(action: {
                        
                        isShowingGameOverSheet = false;
                        self.vm.initialiseBoard()
                        
                    }, label: {
                        Text("Play Again?")
                    })
                })
        }
    }
    
    @ViewBuilder func markedPositionView(_ position: Position) -> some View {
        ZStack {
            
            Circle()
                .fill(.black)
                .frame(width: Constants.mainPositionWidth, height: Constants.mainPositionHeight)
            
            Circle()
                .fill(position.marked == .player1 ? .red : .blue)
                .frame(width: Constants.markedPositionWidth, height: Constants.mainPositionHeight)
            
        }
    }
    
    @ViewBuilder func singleCircleView(_ position: Position) -> some View {
        
        Button(action: {
            
            self.vm.markPosition(position: position) { gameover in
                if gameover {
                    self.isShowingGameOverSheet = true;
                }
            }
            
        }, label: {
            
            if position.marked == nil {
                
                Circle()
                    .fill(.black)
                    .frame(width: Constants.mainPositionWidth, height: Constants.mainPositionHeight)
                
            } else {
                markedPositionView(position);
            }
              
        })
       
    }
    
    @ViewBuilder func scoreView() -> some View {
        
        HStack {
            
            ForEach(0..<ScoreManager.singelton.scores.count) { index in
                
                let player = ScoreManager.singelton.getPlayer(index);
                let count = ScoreManager.singelton.getScore(player);
                
                Text("\(player.rawValue) : \(count)")
            }
        }
        
    }
    
    @ViewBuilder func connectGridView() -> some View {
        
        ScrollView(.horizontal) {
        Grid(horizontalSpacing: 10, verticalSpacing: 10) {
            
            ForEach(0..<self.vm.board.count) { row in
                
                GridRow {
                    
                    ForEach(self.vm.board[row]) { position in
                        singleCircleView(position);
                    }
                    
                }
                
            }
        }
        }
        
    }
    
    }
    

struct Constants {
    
    static let mainPositionHeight: CGFloat = 50;
    static let mainPositionWidth: CGFloat = 50;
    
    static let markedPositionHeight: CGFloat = 5;
    static let markedPositionWidth: CGFloat = 5;

}


#Preview {
    ContentView()
}
