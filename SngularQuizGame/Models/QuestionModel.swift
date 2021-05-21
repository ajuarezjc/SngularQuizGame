//
//  Question.swift
//  SngularQuizGame
//
//  Created by Alejandro Juarez on 20/05/21.
//

import Foundation

struct QuestionModel : Decodable{
    let Question : String
    let OptionA : String
    let OptionB : String
    let Answer : String
}
