//
//  EventCollectionCell.swift
//  MDB Social
//
//  Created by Marco Monfiglio on 4/5/22.
//

import UIKit
import Firebase

class EventCollectionCell: UICollectionViewCell {
    
    
    let storage = Storage.storage()
    static let reuseIdentifier: String = String(describing: EventCollectionCell.self)
    
    var event: Event? {
        didSet {
            let urlRef: StorageReference = storage.reference(forURL: event!.photoURL)
                urlRef.getData(maxSize: 2000*2000) { data, error in
                    if let error = error {
                        print("Error: \(error)")
                    } else {
                        self.imageView.image = UIImage(data: data!)
                    }
                }
            
            let creatorRef = DatabaseRequest.shared.db.collection("users").document(event!.creator)
                creatorRef.getDocument(completion: { querySnapshot, error in
                    if let error = error {
                        print(error)
                    } else {
                        guard let user = try? querySnapshot?.data(as: User.self) else { return }
                        self.creatorView.text = user.fullname
                    
                    }
                })
                    

            titleView.text = "\(event?.name ?? "")"
            guestView.text = "\(event?.rsvpUsers.count ?? 0) are Interested"
        }
    }
    
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
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let creatorView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let guestView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleView)
        contentView.addSubview(creatorView)
        contentView.addSubview(guestView)
        
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            creatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            creatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            creatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            guestView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 75),
            guestView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            guestView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

