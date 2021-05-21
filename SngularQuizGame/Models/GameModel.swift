//
//  QuizModel.swift
//  SngularQuizGame
//
//  Created by Alejandro Juarez on 20/05/21.
//

import Foundation

struct GameModel {
    private var rightGuesses : Int = 0
    private var wrongGuesses : Int = 0
    private var currentQuestionIndex : Int = 0
    
    private var allQuestions : [QuestionModel]
    var totalQuestions : Int {
        return allQuestions.count
    }
    
    var currentQuestion : QuestionModel {
        return allQuestions[currentQuestionIndex]
    }
    
    init(withQuestions questionsForGame : [QuestionModel]) {
        self.rightGuesses = 0
        self.wrongGuesses = 0
        self.currentQuestionIndex = 0
        self.allQuestions = questionsForGame
    }
    
    mutating func resetGame(){
        self.rightGuesses = 0
        self.wrongGuesses = 0
        self.currentQuestionIndex = 0
    }
    
    mutating func shuffleQuestions(){
        allQuestions.shuffle()
    }
    
    mutating func goToNextQuestion(){
        self.currentQuestionIndex += 1
    }
    

    
}


