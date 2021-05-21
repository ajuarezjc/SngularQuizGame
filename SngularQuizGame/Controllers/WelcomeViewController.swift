//
//  WelcomeViewController.swift
//  SngularQuizGame
//
//  Created by Alejandro Juarez on 20/05/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Adding Welcome Label
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - IB Actions
    
    //Action performed when button Let's Go is pressed
    @IBAction func buttonLetsGoPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToQuestions", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
