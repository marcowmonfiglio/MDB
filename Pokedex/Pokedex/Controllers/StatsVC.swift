//
//  StatsVC.swift
//  Pokedex
//
//  Created by Marco Monfiglio on 3/15/22.
//

import UIKit

class StatsVC: UIViewController {
    
    var poke: Pokemon
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: >> Your Code Here <<
    
    init(symbol: Pokemon) {
        self.poke = symbol
        super.init(nibName: nil, bundle: nil)
    }
    
    
    //imageURL (try animated or large)
    let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        
        return view
        
    }()
    
    var typeColor: [String: UIColor] = ["Grass": #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), "Dark": #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), "Ground": #colorLiteral(red: 0.7884706259, green: 0.3518863916, blue: 0, alpha: 1), "Dragon": #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), "Ice": #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), "Electric": #colorLiteral(red: 0.9966529012, green: 1, blue: 0, alpha: 1), "Normal": #colorLiteral(red: 0.6951308846, green: 0.4658972621, blue: 0.6436214447, alpha: 1), "Fairy": #colorLiteral(red: 0.9537460208, green: 0.5270368457, blue: 0.7791104913, alpha: 1), "Poison": #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), "Fighting": #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), "Psychic": #colorLiteral(red: 0.9791921973, green: 0.3354279995, blue: 0.5399469137, alpha: 1), "Fire": #colorLiteral(red: 1, green: 0.3136056066, blue: 0, alpha: 1), "Rock": #colorLiteral(red: 0.4287654161, green: 0.09344018251, blue: 0, alpha: 1), "Flying": #colorLiteral(red: 0.1503745914, green: 0.4267224073, blue: 0.6114747524, alpha: 1), "Steel": #colorLiteral(red: 0.1663994491, green: 0.551825583, blue: 0.3688330054, alpha: 1), "Ghost": #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1), "Water": #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), "Unknown": #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]
    
    var labelNames: [String] = ["Id", "Attack", "Defense", "Health", "Special Attack", "Special Defense", "Speed", "Total"]
    var labelData:[Int] = []
    
    let nameHeader: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.shadowOffset = CGSize(width: 1, height: 1)
        label.shadowColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        label.font = .systemFont(ofSize: 50, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labels: [UILabel] = { // [id, attack, defense, health, specialAttack, specialDefense, speed, total]
        return (0..<17).map { index in
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            if index < 8 {
                label.layer.borderWidth = 3
                label.layer.cornerRadius = 5
            }
            return label
        }
    }()
    
    let returnButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal) //.blue
        button.setTitle("Back", for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setUpConstraints()
        addInfo()
        returnButton.addTarget(self, action: #selector(tapReturnHandler(_:sender:)), for: .touchUpInside)
        
    }
    
    private func addSubViews() {
        view.addSubview(returnButton)
        view.addSubview(nameHeader)
        view.addSubview(imageView)
        
        for i in 0..<17 {
            view.addSubview(labels[i])
        }
    }
    
    private func setUpConstraints() {
        nameHeader.heightAnchor.constraint(equalToConstant: 75).isActive = true
        nameHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: nameHeader.bottomAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
     
        for i in 0..<8 {
            labels[i].backgroundColor = typeColor["\(poke.types[0])"]
            if i == 0 {
            labels[i].topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
            } else {
                labels[i].topAnchor.constraint(equalTo: labels[i-1].bottomAnchor, constant: 5).isActive = true
            }
            labels[i].heightAnchor.constraint(equalToConstant: 35).isActive = true
            labels[i].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            labels[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        }
        for i in 8..<16 {
            if i == 8 {
                labels[i].topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
            } else {
                labels[i].topAnchor.constraint(equalTo: labels[i-1].bottomAnchor, constant: 5).isActive = true
            }
            labels[i].heightAnchor.constraint(equalToConstant: 35).isActive = true
            labels[i].trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35).isActive = true
            labels[i].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        }
        
        returnButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        returnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        returnButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        returnButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(25)).isActive = true
        
    }
    
    private func addInfo() { // WORK ON SETTING THE BACKGROUND
        
        if let url = poke.imageUrlLarge {
            let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, response, error in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
            task.resume()
        } else {
            self.imageView.image = #imageLiteral(resourceName: "pokeball")
        }
        
        nameHeader.text = poke.name
        labelData.append(poke.id)
        labelData.append(poke.attack)
        labelData.append(poke.defense)
        labelData.append(poke.health)
        labelData.append(poke.specialAttack)
        labelData.append(poke.specialDefense)
        labelData.append(poke.speed)
        labelData.append(poke.total)
        
        for i in 0..<8 {
            labels[i].text = "  \(labelNames[i]): "
        }
        for i in 0..<8 {
            labels[8+i].text = "\(labelData[i])  "
            labels[8+i].textAlignment = .right
        }
        
    }
    
    
    @objc func tapReturnHandler(_ action: UIAction, sender: UIButton) {
        
        
        let vc = PokedexVC()
        
        
        dismiss(animated: true)
    }
}

