//
//  TypeFilterVC.swift
//  Pokedex
//
//  Created by Marco Monfiglio on 3/27/22.
//

import UIKit

class TypeFilterVC: UIViewController {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    var typeList: [String] = []
    
    var indexToString: [Int: String] = [0: "Grass", 1: "Dark", 2: "Ground", 3: "Dragon", 4: "Ice", 5: "Electric", 6: "Normal", 7: "Fairy", 8: "Poison", 9: "Fighting", 10: "Psychic", 11: "Fire", 12: "Rock", 13: "Flying", 14: "Steel", 15: "Ghost", 16: "Water", 17: "Unknown"]
    
    var typeColor: [String: UIColor] = ["Grass": #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), "Dark": #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), "Ground": #colorLiteral(red: 0.7884706259, green: 0.3518863916, blue: 0, alpha: 1), "Dragon": #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), "Ice": #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), "Electric": #colorLiteral(red: 0.9966529012, green: 1, blue: 0, alpha: 1), "Normal": #colorLiteral(red: 0.6951308846, green: 0.4658972621, blue: 0.6436214447, alpha: 1), "Fairy": #colorLiteral(red: 0.9537460208, green: 0.5270368457, blue: 0.7791104913, alpha: 1), "Poison": #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), "Fighting": #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), "Psychic": #colorLiteral(red: 0.9791921973, green: 0.3354279995, blue: 0.5399469137, alpha: 1), "Fire": #colorLiteral(red: 1, green: 0.3136056066, blue: 0, alpha: 1), "Rock": #colorLiteral(red: 0.4287654161, green: 0.09344018251, blue: 0, alpha: 1), "Flying": #colorLiteral(red: 0.1503745914, green: 0.4267224073, blue: 0.6114747524, alpha: 1), "Steel": #colorLiteral(red: 0.1663994491, green: 0.551825583, blue: 0.3688330054, alpha: 1), "Ghost": #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), "Water": #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), "Unknown": #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]
    
    let buttons: [UIButton] = {
        return (0..<18).map { index in
            let button = UIButton()
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 7
            button.layer.borderWidth = 2
            button.backgroundColor = #colorLiteral(red: 0.8851273656, green: 0.8851273656, blue: 0.8851273656, alpha: 1)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = index
            return button
        }
    }()
    
    private let header: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Type Filter"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 45, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let returnButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal) //.blue
        button.setTitle("Back", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8851273656, green: 0.8851273656, blue: 0.8851273656, alpha: 1)
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubViews()
        setUpConstraints()
        initCallbacks()
        configButtons()
    }
    
    func addSubViews() {
        view.addSubview(header)
        view.addSubview(returnButton)
        
        for i in 0..<18 {
            view.addSubview(buttons[i])
        }
    }
    
    func setUpConstraints() {
        header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        returnButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        returnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        returnButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        returnButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        for i in 0..<6 {
            for j in 0..<3 {
                if j == 0 {
                    buttons[3*i+j].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22).isActive = true
                } else {
                    buttons[3*i+j].leadingAnchor.constraint(equalTo: buttons[3*i+j-1].trailingAnchor, constant: 22).isActive = true
                }
                buttons[3*i+j].widthAnchor.constraint(equalToConstant: 100).isActive = true
                buttons[3*i+j].heightAnchor.constraint(equalToConstant: 75).isActive = true
                buttons[3*i+j].topAnchor.constraint(equalTo: header.bottomAnchor, constant: CGFloat(30+100*i)).isActive = true
            }
            
        }
    }
    
    func configButtons() {
        for i in 0..<18 {
            buttons[i].setTitle(indexToString[i], for: .normal)
        }
    }
    
    func initCallbacks() {
        returnButton.addTarget(self, action: #selector(tapReturnHandler(_:)), for: .touchUpInside)
        for i in 0..<18 {
            buttons[i].addTarget(self, action: #selector(addType(_:)), for: .touchUpInside)
        }
    }
    
    @objc func addType(_ sender: UIButton) {
        if let myType = indexToString[sender.tag] {
            typeList.append(myType)
            buttons[sender.tag].backgroundColor = .systemGreen
            print(typeList)
        }
    }
    
    
    @objc func tapReturnHandler(_ sender: UIButton) {
        //PokedexVC.filteredType = typeList
        dismiss(animated: true)
    }
}
