//
//  QuestionViewController.swift
//  Unit3GuidedProjectForSubmit
//
//  Created by Tomona Sako on 2020/05/07.
//  Copyright © 2020 Tomona Sako. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var chosenAnswers : [Answer] = []
    
    let questions: [Question] = [
 Question(text: "Which food do you like the most?", type: .single,
                   answers: [
     Answer(text: "Steak", type: .dog),
     Answer(text: "Fish", type: .cat),
     Answer(text: "Carrots", type: .rabbit),
     Answer(text: "Corn", type: .turtle)
     ]
 ),
 Question(text: "Which activities do you enjoy?", type: .multiple,
                   answers: [
     Answer(text: "Swimming", type: .turtle),
     Answer(text: "Sleeping", type: .cat),
     Answer(text: "Cuddling", type: .rabbit),
     Answer(text: "Running", type: .dog)
     ]
 ),
 Question(text: "How much do you enjoy car rides?", type: .ranged,
                   answers: [
     Answer(text: "I dislike them", type: .cat),
     Answer(text: "I get a little nervous", type: .rabbit),
     Answer(text: "I berely notice them", type: .turtle),
     Answer(text: "I love them", type: .dog)
         ]
     )
    ]
    
    var questionIndex = 0
       
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var questionProgressView: UIProgressView!
    @IBOutlet var rangeStackView: UIStackView!
    
    @IBOutlet var rangeLabel1: UILabel!
    @IBOutlet var rangeLabel2: UILabel!
    
    @IBOutlet var rangedSlider: UISlider!
    
    @IBOutlet var multipleStackView: UIStackView!
    
    @IBOutlet var multiLabel1: UILabel!
    @IBOutlet var multiLabel2: UILabel!
    @IBOutlet var multiLabel3: UILabel!
    @IBOutlet var multiLabel4: UILabel!
    @IBOutlet var multiSwitch1: UISwitch!
    @IBOutlet var multiSwitch2: UISwitch!
    @IBOutlet var multiSwitch3: UISwitch!
    @IBOutlet var multiSwitch4: UISwitch!
    
    @IBOutlet var singleStackView: UIStackView!

    @IBOutlet var singleButton1: UIButton!
    @IBOutlet var singleButton2: UIButton!
    @IBOutlet var singleButton3: UIButton!
    @IBOutlet var singleButton4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI(questions: questions)
        
    }
    
    
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI(questions: questions)
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            chosenAnswers.append(currentAnswers[0])
        case singleButton2:
             chosenAnswers.append(currentAnswers[1])

        case singleButton3:
             chosenAnswers.append(currentAnswers[2])

        case singleButton4:
             chosenAnswers.append(currentAnswers[3])
        default:
            break
        }
        nextQuestion()

    }
    @IBAction func multipleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            chosenAnswers.append(currentAnswers[0])
        }
       
        if multiSwitch2.isOn {
            chosenAnswers.append(currentAnswers[1])
        }
        if multiSwitch3.isOn {
            chosenAnswers.append(currentAnswers[2])
        }
        if multiSwitch4.isOn {
            chosenAnswers.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    @IBAction func rangedAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        chosenAnswers.append(currentAnswers[index])
        nextQuestion()
        
    }

    
    func updateSingle(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text , for: .normal)
        singleButton2.setTitle(answers[1].text , for: .normal)
        singleButton3.setTitle(answers[2].text , for: .normal)
        singleButton4.setTitle(answers[3].text , for: .normal)
    }
    func updateMultiple(using answers: [Answer]) {
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
    
    func updateRange(using answers: [Answer]) {
        rangeStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangeLabel1.text = answers.first?.text
        rangeLabel2.text = answers.last?.text
    }
    
    
    func updateUI(questions: [Question]) {
        let totalProgress = Float(questionIndex) / Float(questions.count)
        let currentQuestion = questions[questionIndex]
        let answers = currentQuestion.answers
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        currentQuestionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)


        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangeStackView.isHidden = true
        
        switch currentQuestion.type {
        case .single :
            updateSingle(using: answers)
        case .multiple :
            updateMultiple(using: answers)
        case .ranged :
            updateRange(using: answers)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "ResultsSegue" {
                let resultsViewController = segue.destination as! ResutltsViewController
                resultsViewController.responses = chosenAnswers

            }
        }
}
