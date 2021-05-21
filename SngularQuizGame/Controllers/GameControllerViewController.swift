//
//  GameControllerViewController.swift
//  SngularQuizGame
//
//  Created by Alejandro Juarez on 20/05/21.
//

import UIKit

class GameControllerViewController: UIViewController {
    
    /*IB Outlets*/
    @IBOutlet weak var labelQuestionText: UILabel!
    @IBOutlet weak var buttonOptionA: UIButton!
    @IBOutlet weak var buttonOptionB: UIButton!
    @IBOutlet weak var questionCounter: UILabel!
    
    /*Controller Variables*/
    var game : GameModel!
    var timeBetweenQuestions = 2.0

    override func viewDidLoad() {
        super.viewDidLoad()

        //Load the questions and set a new game
        //This could/should be done on GameModel.swift too
        if let questionsForGame = getQuestions(){
            //Init the game
            game = GameModel(withQuestions: questionsForGame)
            game.shuffleQuestions()
        }
        
        //Setting tags for buttons for easy answer check
        buttonOptionA.tag = AnswerSelected.A.buttonTag
        buttonOptionB.tag = AnswerSelected.B.buttonTag
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Set the initial question and options
        updateQuestionInView()
    }
    
    // MARK: - Controller Functions
    
    //Load questions
    func getQuestions()->[QuestionModel]?{
        if let path = Bundle.main.path(forResource: "Questions", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let questions = try JSONDecoder().decode([QuestionModel].self, from: data)
                return questions
            } catch let err {
                //Something wrong happened, return nil
                print("Error while getting questions:\n"+err.localizedDescription)
                return nil
            }
        } else{
            return nil
        }
        
    }
    
    func updateQuestionInView(advanceQuestion goToNextQuestion : Bool = false){
        //Check if we have to go to next question
        if goToNextQuestion {
            game.goToNextQuestion()
        }
        //Display current question in View
        //Question
        labelQuestionText.text = game.currentQuestion.Question
        //Option A
        buttonOptionA.setTitle(game.currentQuestion.OptionA, for: .normal)
        //Option B
        buttonOptionB.setTitle(game.currentQuestion.OptionB, for: .normal)
        //Update the counter label
        questionCounter.text = "\(game.currentQuestionIndex)/\(game.totalQuestions)"
    }
    
    // MARK: - IB Actions
    
    //Action when either button is pressed
    @IBAction func buttonAnswerSelected(_ sender: UIButton) {
        //Get the tag of the button pressed
        let buttonTagPressed = sender.tag
        //Get the answer for this question
        let answerTag = game.currentAnswer.buttonTag
        //Check if the answer is correct or not and count it
        let answerIsOk = (buttonTagPressed == answerTag)
        //Add the answer to the Game
        game.addAnswer(isAnswerRight: answerIsOk)
        
        //Check if we were at the last question
        if(game.gameIsOver){
            //Alert the end is over and show results
            let (correctAnswers, incorrectAnswers) = game.getResults()
            let message = "Correctas: \(correctAnswers)\nIncorrectas: \(incorrectAnswers)\n"
            
            let alertGameOver = UIAlertController(title: "¡Eso fue todo!", message: message, preferredStyle: .alert)
            
            let buttonRepeatGame = UIAlertAction(title: "Jugar otra vez", style: .destructive) {[unowned self] (action) in
                game.resetGame()
                updateQuestionInView()
            }
            
            alertGameOver.addAction(buttonRepeatGame)
            
            present(alertGameOver, animated: true) {
            }
            
        }
        //Game is not over, we can go to next question
        else{
            //Set timer to update next question in N seconds
            Timer.scheduledTimer(withTimeInterval: timeBetweenQuestions, repeats: false) {[unowned self] (timer) in
                updateQuestionInView(advanceQuestion: true)
            }
        }
    }
    
    

}
