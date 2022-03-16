//
//  PokedexCollectionCell.swift
//  Pokedex
//
//  Created by Marco Monfiglio on 3/11/22.
//

import Foundation
import UIKit

class PokedexCollectionCell: UICollectionViewCell {
    
    
    static let reuseIdentifier: String = String(describing: PokedexCollectionCell.self)
    
    var onePokemon: Pokemon? {
        didSet {
            if let url = onePokemon?.imageUrl {
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
            titleView.text = onePokemon?.name
            IDView.text = String(describing: onePokemon!.id)
            
        }
    }
    
    //private var classType: String
    //private var typeColor: UIColor
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let IDView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1058823529, blue: 0.1098039216, alpha: 1)
        contentView.layer.borderColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        contentView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        contentView.addSubview(IDView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
 Lesson 5: Firebase
 
 - Using firebase data store feature as an interactive database that can call their swift functions and access the database. Can call their API function within swift
 - Firebase Authentication: built in features that can be called from within Swift; handles the authenitcation process automatically
 - Authentication and Firestore Databse are two microfunctions used frequently;
 - Collections of events which have documents attached to them
 Enforce "Schema?" esssentially each datatype has to have each element of required data; <id, name, age> for example has to have a value in each entry
 - Project 3A: Create a registration within firebase; username, password in authentication, and all other data stored in FIRESTORE <FULLNAME, EVENTNAME> etc
 - The field for each data type has certain type restrication
 - Firebase storage keeps big files such as images, files, videos, media files etc.
 - Use in the built in SDK function which is in the storage package
 - Use URLSessionDataTask to run the url
 - Firebase hosting: Web API to host an instanceo of that API
 - Firebase functions: Select a web API function to run and write it as a firebase function
 
 */
