//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController {
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()
    
    private let StatsHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Current Stats"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 27, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var searchBar: UISearchBar {
        let search = UISearchBar()
        search.tintColor = .cyan
        search.text = "Find a Pokémon!"
        search.barStyle = .black
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func addSubViews() {
        view.addSubview(searchBar)
        view.addSubview(StatsHeader)
    }
    
    func setUpConstraints() {
        StatsHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        StatsHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        StatsHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    }
}

