//
//  QuestionViewController.swift
//  PersonalityQuiz_swift
//
//  Created by Apple Device 9 on 11/8/19.
//  Copyright © 2019 jun. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiLabel4: UILabel!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    var questions = [
        Question(text: "Pregunta 1", type: .single, answers:[
            Answer(text: "Respuesta 1.1", type: .resultado1),
            Answer(text: "Respuesta 1.2", type: .resultado2),
            Answer(text: "Respuesta 1.3", type: .resultado3),
            Answer(text: "Respuesta 1.4", type: .resultado4),
            ]),
        Question(text: "Pregunta 2", type: .multiple, answers:[
            Answer(text: "Respuesta 2.1", type: .resultado1),
            Answer(text: "Respuesta 2.2", type: .resultado2),
            Answer(text: "Respuesta 2.3", type: .resultado3),
            Answer(text: "Respuesta 2.4", type: .resultado4),
            ]),
        Question(text: "Pregunta 3", type: .ranged, answers:[
            Answer(text: "Respuesta 3.1", type: .resultado1),
            Answer(text: "Respuesta 3.2", type: .resultado2)
            ])
    ]
    var questionIndex = 0
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
    
        navigationItem.title = "Question #\(questionIndex + 1)"
        
        let currentQuestion = questions[questionIndex]
        let currentAnswers = currentQuestion.answers
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswers)
        case .multiple:
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            updateRangedStack(using: currentAnswers)
        }
    
        questionLabel.text = currentQuestion.text

        let totalProgress = Float(questionIndex) / Float(questions.count)
        progressView.setProgress(totalProgress, animated: true)

       

}
    func updateSingleStack(using answers: [Answer]){
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    var answersChosen: [Answer] = []
    
    @IBAction func singleAnswerButotnClicked(_ sender: UIButton){
        let currentAnswers = questions[questionIndex].answers
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
            answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
       nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonClicked(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        if multiSwitch2.isOn {
            answersChosen.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            answersChosen.append(currentAnswers[3])
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonClicked(_ sender: Any) {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        nextQuestion()
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        }else{
            print(answersChosen)
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    
}
