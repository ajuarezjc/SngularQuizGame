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
    var timeBetweenQuestions = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()

        //Load the questions and set a new game
        //This could/should be done on GameModel.swift too
        if let questionsForGame = getQuestions(){
            //Init the game
            game = GameModel(withQuestions: questionsForGame)
            game.shuffleQuestions()
            updateQuestionInView()
        }
        
        //Setting tags for buttons for easy answer check
        buttonOptionA.tag = AnswerSelected.A.buttonTag
        buttonOptionB.tag = AnswerSelected.B.buttonTag
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Set the initial question and options
        //updateQuestionInView()
    }
    
    // MARK: - Controller Functions
    
    //Load questions
    func getQuestions()->[QuestionModel]?{
        if let path = Bundle.main.path(forResource: "Questions", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let questions = try JSONDecoder().decode(QuizData.self, from: data)
                return questions.Questions
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
        labelQuestionText.text = game.currentQuestion.Question + "?"
        //Option A
        buttonOptionA.setTitle(game.currentQuestion.OptionA, for: .normal)
        //Option B
        buttonOptionB.setTitle(game.currentQuestion.OptionB, for: .normal)
        //Enable buttons back
        buttonOptionA.isEnabled = true
        buttonOptionB.isEnabled = true
        //Update the counter label
        questionCounter.text = "\(game.currentQuestionIndex + 1)/\(game.totalQuestions)"
    }
    
    // MARK: - IB Actions
    
    //Action when either button is pressed
    @IBAction func buttonAnswerSelected(_ sender: UIButton) {
        //Block buttons until next question
        buttonOptionA.isEnabled = false
        buttonOptionB.isEnabled = false
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
            let (correctAnswers, incorrectAnswers, finalMark) = game.getResults()
            let finalNote = (finalMark >= 60.0) ? "¡Buen trabajo!" : "¡Más suerte la próxima!"
            let message = "\nCorrectas: \(correctAnswers)\nIncorrectas: \(incorrectAnswers)\n\nPuntaje: \(String(format: "%.1f", finalMark))%" + "\n\(finalNote)\n"
            let alertGameOver = UIAlertController(title: "¡Eso fue todo!", message: message, preferredStyle: .alert)
            
            let buttonRepeatGame = UIAlertAction(title: "Jugar otra vez", style: .default) {[unowned self] (action) in
                game.resetGame()
                updateQuestionInView()
            }
            let buttonQuitGame = UIAlertAction(title: "Finalizar", style: .destructive) { [unowned self] (action) in
                self.dismiss(animated: true) {
                }
            }
            
            alertGameOver.addAction(buttonRepeatGame)
            alertGameOver.addAction(buttonQuitGame)
            
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
    
    //Button when button Cancel is pressed
    @IBAction func buttonCancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
        }
    }
    

}
