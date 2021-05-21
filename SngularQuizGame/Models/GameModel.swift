//
//  QuizModel.swift
//  SngularQuizGame
//
//  Created by Alejandro Juarez on 20/05/21.
//

import Foundation

struct GameModel {
    var rightGuesses : Int = 0
    var wrongGuesses : Int = 0
    var currentQuestion : Int = 0
    
    var allQuestions : [QuestionModel]
    var totalQuestions : Int {
        return allQuestions.count
    }
    
    mutating func resetGame(){
        self.rightGuesses = 0
        self.wrongGuesses = 0
        self.currentQuestion = 0
    }

    init(withQuestions questionsForGame : [QuestionModel]) {
        self.rightGuesses = 0
        self.wrongGuesses = 0
        self.currentQuestion = 0
        self.allQuestions = questionsForGame
    }
}


