//
//  ViewController.swift
//  Pokedex
//
//  Created by Michael Lin on 2/18/21.
//

import UIKit

class PokedexVC: UIViewController {
    
    var layout = 0
    
    var filter: Bool = false
    
    var filteredPokemon: [Pokemon] = []
    
    let pokemons = PokemonGenerator.shared.getPokemonArray()
    
    var filteredType: [String] = [] //CHECK FOR EMPTY LIST FOR NO FILTER APPLIED ******************************
    
    
    private let welcomeHeader: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Pokedex"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 45, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rowButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.isSpringLoaded = true
        button.setTitle("R", for: .normal)
        button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.tag = 1
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.isSpringLoaded = true
        button.setTitle("G", for: .normal)
        button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.tag = 0
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let typeFilterButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Type", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8851273656, green: 0.8851273656, blue: 0.8851273656, alpha: 1)
        button.isSpringLoaded = true
        button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Search!", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8851273656, green: 0.8851273656, blue: 0.8851273656, alpha: 1)
        button.isSpringLoaded = true
        button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 7
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.tintColor = .darkGray
        search.text = "Find a Pokémon!"
        search.barStyle = .default
        //search.layer.borderWidth = 1
        search.showsScopeBar = true
        search.isTranslucent = true
        search.searchTextField.borderStyle = .roundedRect
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = -1
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokedexCollectionCell.self, forCellWithReuseIdentifier: PokedexCollectionCell.reuseIdentifier) //The collection view has to know what type of cell is being passed;
        //Moves from collection view initiliazition (initializes the type of cell)
        //Goes to the data source to get configured with content
        //Goes to display, and is reused when no longer needed
        return collectionView
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubViews()
        setUpConstraints()
        initCallbacks()
        setUpCollectionView()
        checkButtons()
        
    }
    
    func setUpCollectionView() {
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 275, left: 45, bottom: 30, right: 45))
        collectionView.backgroundColor = .clear
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.dataSource = self //This assigns SFSCollection to be the dataSource in order for collectionView to be able to ask for items
        collectionView.delegate = self //Both data source and delegate are part of the delegate design, but just have different names
        
    }
    
    func addSubViews() {
        view.addSubview(searchBar)
        view.addSubview(welcomeHeader)
        view.addSubview(collectionView)
        view.addSubview(searchButton)
        view.addSubview(rowButton)
        view.addSubview(gridButton)
        view.addSubview(typeFilterButton)
    
    }
    
    func initCallbacks() {
        searchButton.addTarget(self, action: #selector(searchCallback(_:)), for: .touchUpInside) /*Old syntax*/
        typeFilterButton.addTarget(self, action: #selector(typeCallback(_:)), for: .touchUpInside)
        rowButton.addTarget(self, action: #selector(layoutCallback(_:)), for: .touchUpInside)
        gridButton.addTarget(self, action: #selector(layoutCallback(_:)), for: .touchUpInside)
    }
    
    func setUpConstraints() {
        welcomeHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        welcomeHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        welcomeHeader.bottomAnchor.constraint(equalTo: searchBar.topAnchor, constant: -25).isActive = true
        welcomeHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        searchBar.topAnchor.constraint(equalTo: welcomeHeader.bottomAnchor, constant: 25).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: welcomeHeader.bottomAnchor, constant: 75).isActive = true
    
        searchButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 50).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -50).isActive = true
        
        rowButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        rowButton.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: -30).isActive = true
        rowButton.trailingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 5).isActive = true
        
        gridButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        gridButton.leadingAnchor.constraint(equalTo: rowButton.trailingAnchor, constant: -2).isActive = true
        gridButton.trailingAnchor.constraint(equalTo: rowButton.trailingAnchor, constant: 35).isActive = true
        
        typeFilterButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        typeFilterButton.leadingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 10).isActive = true
        typeFilterButton.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 60).isActive = true
        
    }
    
    func layoutIsGrid() -> Bool {
        if layout == 0 {
            return true
        } else {
            
            return false
        }
    }
    
    func checkButtons() {
        if rowButton.tag == layout {
            rowButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else {
            rowButton.backgroundColor = #colorLiteral(red: 0.8851273656, green: 0.8851273656, blue: 0.8851273656, alpha: 1)
        }
        
        if gridButton.tag == layout {
            gridButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else {
            gridButton.backgroundColor = #colorLiteral(red: 0.8851273656, green: 0.8851273656, blue: 0.8851273656, alpha: 1)
        }
        collectionView.reloadData()
    }
    
    @objc func searchCallback (_ sender: UIButton) { //********************************************
        filter = true
        filteredPokemon = []
        for poke in PokemonGenerator.shared.getPokemonArray() {
            if poke.name.contains(searchBar.text!) == true {
                filteredPokemon.append(poke)
            }
        }
        collectionView.reloadData()
    }
    
    @objc func layoutCallback (_ sender: UIButton) {
        if sender.tag != layout  {
            layout = sender.tag
        }
        checkButtons()
        //layoutIsGrid()
    }
    
    @objc func typeCallback (_ sender: UIButton) {
        let vc = TypeFilterVC()
        present(vc, animated: true, completion: nil)
    }
    
    
} //END OF CLASS POKEDEX VC

    
extension PokedexVC: UICollectionViewDataSource { //*****************************************
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filter {
            return filteredPokemon.count
        } else {
        return PokemonGenerator.shared.getPokemonArray().count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
        if filter {
            symbol = filteredPokemon[indexPath.item]
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCollectionCell.reuseIdentifier, for: indexPath) as! PokedexCollectionCell
        cell.onePokemon = symbol
        return cell
    }
}


extension PokedexVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if layoutIsGrid() {
            return CGSize(width: 150, height: 80)
        } else {
            return CGSize(width: 300, height: 40)
        }
         // ****************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************************
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
        if filter {
            symbol = filteredPokemon[indexPath.item]
        }
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return PokedexPreviewVC(symbol: symbol)
        }) { _ in
            let okItem = UIAction(title: "OK", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) { _ in }
            return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var symbol = PokemonGenerator.shared.getPokemonArray()[indexPath.item]
        if filter {
            symbol = filteredPokemon[indexPath.item]
        }
        let vc = StatsVC(symbol: symbol)
        present(vc, animated: true, completion: nil)
    }
}

/*
Lesson Notes:
1. collectionview's data source is assigned to collectionviwe or self
2. Delegetate flow layout; implements optional behavior
3. 'Size for item at' function sets the cell size or the default could be used
4. 'Did select item at' function is the callback for when a cell is selected; the delegate gives the callback functionality to the cell
5.
 */
