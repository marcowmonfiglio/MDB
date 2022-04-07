//
//  StatsVC.swift
//  Meet the Members
//
//  Created by Michael Lin on 1/18/21.
//

import UIKit

class StatsVC: UIViewController {
    
    // MARK: STEP 11: Going to StatsVC
    // Read the instructions in MainVC.swift
    
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
    
    
//    let dataExample: String
    var highScore: Int = 0
    var streak: [String] = []
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: >> Your Code Here <<
    
    init(highScore: Int, streak: [String]) {
        self.highScore = highScore
        self.streak = streak
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: STEP 12: StatsVC UI
    // Action Items:
    // - Initialize the UI components, add subviews and constraints
    
    private let StatsHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Current Stats:"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labels: [UILabel] = {
        return (0..<3).map { index in
            let label = UILabel()
            label.textColor = .darkGray
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tag = index
            
            return label
        }
        
        
    }()
    
    private let highScoreHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailHeader: UILabel = {
        let label = UILabel()
        label.text = "Most Recent Questions:"
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 27, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let ReturnButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Back", for: .normal)
        button.backgroundColor = .cyan
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: >> Your Code Here <<
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setUpConstraints()
        addLabelText()
        ReturnButton.addTarget(self, action: #selector(tapReturnHandler(_:sender:)), for: .touchUpInside)
        
        
        // MARK: >> Your Code Here <<
    }
    
    private func addSubViews() {
        view.addSubview(StatsHeader)
        view.addSubview(ReturnButton)
        view.addSubview(highScoreHeader)
        view.addSubview(detailHeader)
        for i in 0..<3 {
            view.addSubview(labels[i])
        }
    }
    
    private func addLabelText() {
        highScoreHeader.text = "Highest Score: \(self.highScore)"
        for i in 0..<streak.count {
            labels[i].text = "\(i+1). \(streak[streak.count - 1 - i])"
        }
    }
    
    private func setUpConstraints() {
        StatsHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        StatsHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        StatsHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        
        highScoreHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        highScoreHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        highScoreHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 175).isActive = true
        
        detailHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        detailHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        detailHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 225).isActive = true
        
        ReturnButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ReturnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        ReturnButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        ReturnButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(25)).isActive = true
        
        for i in 0..<3 {
            labels[i].heightAnchor.constraint(equalToConstant: 75).isActive = true
            labels[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 75).isActive = true
            labels[i].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -75).isActive = true
            labels[i].topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(250 + 25*i)).isActive = true
        }
    }
    
    
    
    
    
    @objc func tapReturnHandler(_ action: UIAction, sender: UIButton) {
        
        
        let vc = MainVC()
        
        vc.modalPresentationStyle = .fullScreen
        
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
        
        dismiss(animated: true)
    }
}
