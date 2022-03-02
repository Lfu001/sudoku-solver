//
//  sudokuSolver.swift
//  sudoku
//
//  Created by Lfu on 2022/03/02.
//

import Foundation

class SudokuSolver {
    func solve(board: inout [[String]]) {
        let emptyCells = self.getEmptyCells(board: board)
        _ = self.backtrack(board: &board, emptyCells: emptyCells)
    }
    
    func backtrack(board: inout [[String]], emptyCells: [(Int, Int)], currentCell: Int = 0) -> Bool {
        if currentCell >= emptyCells.count {
            return true
        }
        let (i, j) = emptyCells[currentCell]
        for num in ["1", "2", "3", "4", "5", "6", "7", "8", "9"] {
            if self.checkAroundMe(board: board, rowIndex: i, columnIndex: j, num: num) {
                board[i][j] = num
                if self.backtrack(board: &board, emptyCells: emptyCells, currentCell: currentCell + 1) {
                    return true
                }
                board[i][j] = "."
            }
        }
        return false
    }
    
    func checkAroundMe(board: [[String]], rowIndex: Int, columnIndex: Int, num: String) -> Bool {
        let myRow = board[rowIndex]
        let myColumn = board.map {
            $0[columnIndex]
        }
        let myBoxRow = rowIndex / 3 * 3
        let myBoxColumn = columnIndex / 3 * 3
        var myBox: [String] = []
        for row in 0...2 {
            for col in 0...2 {
                myBox.append(board[myBoxRow + row][myBoxColumn + col])
            }
        }
        for line in [myRow, myColumn, myBox] {
            if line.contains(num) {
                return false
            }
        }
        return true
    }
    
    func getEmptyCells(board: [[String]]) -> [(Int, Int)] {
        var emptyCells: [(Int, Int)] = []
        for i in 0..<9 {
            for j in 0..<9 {
                if board[i][j] == "." {
                    emptyCells.append((i, j))
                }
            }
        }
        return emptyCells
    }
}


var board = [["5", "3", ".", ".", "7", ".", ".", ".", "."],
             ["6", ".", ".", "1", "9", "5", ".", ".", "."],
             [".", "9", "8", ".", ".", ".", ".", "6", "."],
             ["8", ".", ".", ".", "6", ".", ".", ".", "3"],
             ["4", ".", ".", "8", ".", "3", ".", ".", "1"],
             ["7", ".", ".", ".", "2", ".", ".", ".", "6"],
             [".", "6", ".", ".", ".", ".", "2", "8", "."],
             [".", ".", ".", "4", "1", "9", ".", ".", "5"],
             [".", ".", ".", ".", "8", ".", ".", "7", "9"]]
             
// The world's hardest sudoku
var board2 = [[".", ".", "5", "3", ".", ".", ".", ".", "."],
              ["8", ".", ".", ".", ".", ".", ".", "2", "."],
              [".", "7", ".", ".", "1", ".", "5", ".", "."],
              ["4", ".", ".", ".", ".", "5", "3", ".", "."],
              [".", "1", ".", ".", "7", ".", ".", ".", "6"],
              [".", ".", "3", "2", ".", ".", ".", "8", "."],
              [".", "6", ".", "5", ".", ".", ".", ".", "9"],
              [".", ".", "4", ".", ".", ".", ".", "3", "."],
              [".", ".", ".", ".", ".", "9", "7", ".", "."]]

print(board2)

let solver = SudokuSolver()

let startTime = Date()
solver.solve(board: &board2)
let timeToSolve = Date().timeIntervalSince(startTime)

print(timeToSolve)
print(board2)
