//
//  ResultsViewController.swift
//  PersonalityQuiz_swift
//
//  Created by Apple Device 9 on 11/8/19.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultsAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caculatePersonalityResult()
        navigationItem.hidesBackButton = true
       
    }
    
    var responses: [Answer]!
    
    func caculatePersonalityResult() {
        var frecuencyOfAnswers: [Type: Int] = [:]
        let responsesType = responses.map({ $0.type })
        for response in responsesType {
            frecuencyOfAnswers[response] = (frecuencyOfAnswers[response] ?? 0) + 1
        }
        let mostCommonAnswer = frecuencyOfAnswers.sorted { $0.1 > $1.1 }.first!.key
        resultsAnswerLabel.text = "You result is \(mostCommonAnswer.definition)"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }
    
    


}
