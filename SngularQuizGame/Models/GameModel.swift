//
//  QuizModel.swift
//  SngularQuizGame
//
//  Created by Alejandro Juarez on 20/05/21.
//

import Foundation

enum AnswerSelected : String {
    case A = "A"
    case B = "B"
    
    var buttonTag : Int {
        switch self{
        case .A:
            return 0
        case .B:
            return 1
        }
    }
}

struct GameModel {
    private var rightGuesses : Int = 0
    private var wrongGuesses : Int = 0
    var currentQuestionIndex : Int = 0
    
    private var allQuestions : [QuestionModel]
    var totalQuestions : Int {
        return allQuestions.count
    }
    
    var currentQuestion : QuestionModel {
        return allQuestions[currentQuestionIndex]
    }
    
    var currentAnswer : AnswerSelected {
        return AnswerSelected(rawValue: currentQuestion.Answer)!
    }
    
    var gameIsOver : Bool {
        return (currentQuestionIndex + 1) == totalQuestions
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
        self.shuffleQuestions()
    }
    
    mutating func shuffleQuestions(){
        allQuestions.shuffle()
    }
    
    mutating func goToNextQuestion(){
        self.currentQuestionIndex += 1
    }
    
    mutating func addAnswer(isAnswerRight answerOk : Bool){
        if answerOk{
            rightGuesses += 1
        }
        else{
            wrongGuesses += 1
        }
    }
    
    func getResults()->(rightAnswers : Int, wrongAnswers: Int, finalMark : Double){
        let mark = (Double(self.rightGuesses) * 100.0) / Double(self.totalQuestions)
        return (self.rightGuesses, self.wrongGuesses, mark)
    }
    
}


