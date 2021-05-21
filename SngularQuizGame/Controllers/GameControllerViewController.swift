//
//  GameControllerViewController.swift
//  SngularQuizGame
//
//  Created by Alejandro Juarez on 20/05/21.
//

import UIKit

enum AnswerSelected : Int {
    case A = 0
    case B = 1
}

class GameControllerViewController: UIViewController {
    
    /*IB Outlets*/
    @IBOutlet weak var labelQuestionText: UILabel!
    @IBOutlet weak var buttonOptionA: UIButton!
    @IBOutlet weak var buttonOptionB: UIButton!
    
    /*Controller Variables*/
    var game : GameModel!

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
        buttonOptionA.tag = AnswerSelected.A.rawValue
        buttonOptionB.tag = AnswerSelected.B.rawValue
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Set the initial question and options
        
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
    }
    
    
    // MARK: - IB Actions
    

}
