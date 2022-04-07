//
//  FeedVC.swift
//  MDB Social
//
//  Created by Michael Lin on 10/17/21.
//

import UIKit

class FeedVC: UIViewController {
    
    var eventList: [Event] = []
    
    private let signOutButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 20, y: 100, width: 350, height:50))
        btn.backgroundColor = .red
        btn.setImage(UIImage(systemName: "xmark"), for: .normal)
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 30, weight: .medium))
        btn.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        btn.tintColor = .white
        btn.layer.cornerRadius = 25
        
        return btn
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.text = "MDB SOCIALS"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = { //*********************************************
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 150
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(EventCollectionCell.self, forCellWithReuseIdentifier: EventCollectionCell.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        
        
        addSubviews()
        setUpConstraints()
        
        eventList = DatabaseRequest.shared.events(vc: self)
        collectionView.backgroundColor = .clear
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
    
    func reload(new: [Event]) {
        eventList = new
        collectionView.reloadData()
    }
    
    func addSubviews() {
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        view.addSubview(collectionView)
        view.addSubview(signOutButton)
        view.addSubview(titleView)
        
    }
    
    func setUpConstraints() {
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 210, left: 30, bottom: 0, right: 30))
        NSLayoutConstraint.activate([
        titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
        titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        signOutButton.addTarget(self, action: #selector(didTapSignOut(_:)), for: .touchUpInside)
        
    }
    
    @objc func didTapSignOut(_ sender: UIButton) {
        print("SELECTED")
        AuthManager.shared.signOut { [weak self] in
            guard let self = self else { return }
            guard let window = self.view.window else { return }
            
            let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateInitialViewController()
            window.rootViewController = vc
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: nil)
        }
    }
}

extension FeedVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return eventList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let event = eventList[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionCell.reuseIdentifier, for: indexPath) as! EventCollectionCell
        cell.event = event
        return cell
    }
}

extension FeedVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let event = eventList[indexPath.item]
        
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return EventPreviewVC(event: event)
        }) { _ in
            let okItem = UIAction(title: "OK", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) { _ in }
            return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = eventList[indexPath.item]
        print("Selected \(String(describing: event.creator))")
        
    }
}
