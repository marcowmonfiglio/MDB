//
//  MainVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import Foundation
import UIKit

class MainVC: UIViewController {
    
    // Create a property for our timer, we will initialize it in viewDidLoad
    var timer: Timer?
    var timeCheck = 0
    var correctIndex: Int = 0
    var score = 0
    var highScore = 0
    var pause = false
    var questionLog: [String] = []
    
    // MARK: STEP 7: UI Customization
    // Action Items:
    // - Customize your imageView and buttons.
    
    private var information: QuestionProvider.Question? = {
        let quest = QuestionProvider.shared.nextQuestion()
        return quest
        
    }()
    
    private let scoreHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Score:"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 27, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white

        // == UIColor.darkGray
        label.textColor = .darkGray
        
        // == NSTextAlignment(expected type).center
        label.textAlignment = .center
        
        // == UIFont.systemFont(ofSize: 27, UIFont.weight.medium)
        label.font = .systemFont(ofSize: 27, weight: .medium)
        
        // Must have if you are using constraints.
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        // MARK: >> Your Code Here <<
    
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    
    
    let buttons: [UIButton] = {
        return (0..<4).map { index in
            let button = UIButton()

            // Tag the button its index
            button.setTitleColor(.blue, for: .normal)
            button.layer.borderWidth = 3
            
            // MARK: >> Your Code Here <<
            button.backgroundColor = .cyan
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = index
            
            return button
        }
        
        
    }()
    
    //var answerString = getNextQuestion()
    
    
    
    // MARK: STEP 10: Stats Button
    // Action Items:
    // - Follow the examples you've seen so far, create and
    // configure a UIButton for presenting the StatsVC. Only the
    // callback function `didTapStats(_:)` was written for you.
    
    // MARK: >> Your Code Here <<
    
    let statsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Stats", for: .normal)
        button.backgroundColor = .cyan
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
            
    // MARK: >> Your Code Here <<
    
    let pauseButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Pause", for: .normal)
        button.backgroundColor = .cyan
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
   
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        addSubViews()
        updateScore()
        initCallbacks()
        setUpConstraints()
        setUpQuestion()
        startTimer()
        
        // MARK: STEP 6: Adding Subviews and Constraints
        // Action Items:
        // - Add imageViews and buttons to the root view.
        // - Create and activate the layout constraints.
        // - Run the App
        // Additional Information:
        // If you don't like the default presentation style,
        // you can change it to full screen too! However, in this
        // case you will have to find a way to manually to call
        // dismiss(animated: true, completion: nil) in order
        // to go back.
        // modalPresentationStyle = .fullScreen
        // MARK: >> Your Code Here <<
        // MARK: STEP 9: Bind Callbacks to the Buttons
        // Action Items:
        // - Bind the `didTapAnswer(_:)` function to the buttons.
        //startButton.addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        // MARK: >> Your Code Here <<
        // MARK: STEP 10: Stats Button
        // See instructions above.
        // MARK: >> Your Code Here <<
    }
    
    private func initCallbacks() {
        
        statsButton.addTarget(self, action: #selector(tapStatsHandler(_:)), for: .touchUpInside) /*Old syntax*/
        for i in 0..<4 {
            view.addSubview(buttons[i])
            buttons[i].addTarget(self, action: #selector(tapAnswerHandler(_:)), for: .touchUpInside)
        }
        pauseButton.addTarget(self, action: #selector(pauseAnswerHandler(_:)), for: .touchUpInside)
    }
    
    private func addSubViews() {
        view.addSubview(imageView)
        view.addSubview(statsButton)
        view.addSubview(scoreLabel)
        view.addSubview(scoreHeader)
        view.addSubview(pauseButton)
    }
    
    private func setUpConstraints() { //CONSTRAINTS
        
        //IMAGE CONSTRAINTS
        imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 400).isActive = true
        
        //BUTTON CONSTRAINTS
        for i in 0..<4 {
            buttons[i].heightAnchor.constraint(equalToConstant: 75).isActive = true
            buttons[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75).isActive = true
            buttons[i].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75).isActive = true
            buttons[i].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(450 + 90*i)).isActive = true
        }
            
        //SCORE LABEL CONSTRAINTS
        scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200).isActive = true
        scoreLabel.widthAnchor.constraint(equalToConstant: 75).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        //SCORE HEADER CONSTRAINTS
        scoreHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150).isActive = true
        scoreHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200).isActive = true
        scoreHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        //STATS BUTTON CONSTRAINTS
        statsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        statsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        statsButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        statsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(25)).isActive = true
        
        //PAUSE BUTTON CONSTRAINTS
        pauseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pauseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        pauseButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pauseButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(25)).isActive = true
    }
    
    // What's the difference between viewDidLoad() and
    // viewWillAppear()? What about viewDidAppear()?
    override func viewWillAppear(_ animated: Bool) {
        // MARK: STEP 13: Resume Game
        
        // MARK: >> Your Code Here <<
    }
    
        
        
        // MARK: STEP 5: Data Model
        // Action Items:
        // - Get a question instance from `QuestionProvider`
        // - Configure the imageView and buttons with information from
        //   the question instance
        
        // MARK: >> Your Code Here <<
    
    func updateScore() {
        scoreLabel.text = "\(score)"
    }
    
    func setUpQuestion() {
        imageView.image = information?.image
    
        for i in 0..<4 {
            buttons[i].backgroundColor = .cyan
            buttons[i].setTitle(information?.choices[i], for: .normal)
        }
    }
    
    func getNextQuestion() {
        information = QuestionProvider.shared.nextQuestion()
        setUpQuestion()
    }
    
    
    
    // MARK: STEP 8: Buttons and Timer Callback
    // You don't have to
    // Action Items:
    // - Complete the callback function for the 4 buttons.
    // - Complete the callback function for the timer instance
    // - Call `startTimer()` where appropriate
    //
    // Additional Information:
    // Take some time to plan what should be in here.
    // The 4 buttons should share the same callback.
    //
    // Add instance properties and/or methods
    // to the class if necessary. You may need to come back
    // to this step later on.
    //
    // Hint:
    // - Checkout `UIControl.addAction(_:for:)`
    //      (`UIButton` subclasses `UIControl`)
    // - You can use `sender.tag` to identify which button is pressed.
    // - The timer will invoke the callback every one second.
    func startTimer() {
        // Create a timer that calls timerCallback() every one second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
    }
    
    @objc func timerCallback() {
        if pause == false {
            timeCheck += 1
            if timeCheck == 5 {
                
                endRound()
            }
        }
        
        
        
        
        // MARK: >> Your Code Here <<
    }
    
    @objc func pauseAnswerHandler(_ sender: UIButton) { //**********************************************************
        if pause == false {
            pause = true
            sender.backgroundColor = .systemYellow
            sender.setTitle("Resume", for: .normal)
        } else {
            pause = false
            score = 0
            timeCheck = 0
            updateScore()
            sender.backgroundColor = .cyan
            sender.setTitle("Pause", for: .normal)
        }
    }
    

    @objc func tapAnswerHandler(_ sender: UIButton) {
        if pause == false {
            endRound()
            if sender.tag == correctIndex {
                score += 1
            }
            checkHighScore()
            
        }
    }
    
    private func endRound() {
        setUserInteractionEnabled(to: false)
    
        
        UIView.animate(withDuration: 3.0, animations: {
            for i in 0..<4 {
                if self.buttons[i].titleLabel?.text == self.information?.answer {
                    self.correctIndex = i
                    self.buttons[i].backgroundColor = .systemGreen
                } else {
                    self.buttons[i].backgroundColor = .systemRed
                }
            }
        }, completion: {_ in
            self.scoreLabel.text = "\(self.score)"
            self.getNextQuestion()})
        setUserInteractionEnabled(to: true)
        timeCheck = -2
        logQuestion()
    }
    
    private func checkHighScore() {
        if score >= highScore {
            highScore = score
        }
    }
    
    private func logQuestion() {
        let option = information?.answer
        if  option != nil {
            if questionLog.count == 3 {
                for i in 0..<2 {
                    questionLog[i] = questionLog[i+1]
                }
                questionLog[2] = option!
            } else {
                questionLog.append(option!)
            }
            
        }
    }
        
    private func setUserInteractionEnabled(to value: Bool) {
        for i in 0..<4 {
            buttons[i].isUserInteractionEnabled = value
        }
    }

        //}
         //MARK: >> Your Code Here <<
    
    @objc func tapStatsHandler(_ sender: UIButton) {
        pause = true
        
        
        let vc = StatsVC(highScore: highScore, streak: questionLog)
        
        //vc.modalPresentationStyle = .fullScreen
        
        // MARK: STEP 11: Going to StatsVC
        // When we are navigating between VCs (e.g MainVC -> StatsVC),
        // we often need a mechanism for transferring data
        // between view controllers. There are many ways to achieve
        // this (initializer, delegate, notification center,
        // combined, etc.). We will start with the easiest one today,
        // which is custom initializer.
        //
        // Action Items:
        // - Pause the game when stats button is tapped i.e. stop the timer
        // - Read the example in StatsVC.swift, and replace it with
        //   your custom init for `StatsVC`
        // - Update the call site here on line 139
        
        present(vc, animated: true, completion: nil)
    }
}




/*Project Notes: 2/26/22

1. Create a button
2. Create a callback function with either objc or uiaction
3. initialize the button in viewdidload
    
}


UIAction
 
 
 */
