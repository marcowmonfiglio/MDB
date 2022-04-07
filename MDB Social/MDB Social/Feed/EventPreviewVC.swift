//
//  EventPreviewVC.swift
//  MDB Social
//
//  Created by Marco Monfiglio on 4/5/22.
//

import UIKit
import CoreData
import Firebase

class EventPreviewVC: UIViewController {
    
    private let imageView = UIImageView()

    override func viewDidLoad() {
        view.addSubview(imageView)
        let width = 110
        let height = 110
        preferredContentSize = CGSize(width: width, height: height)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    init(event: Event) {
        super.init(nibName: nil, bundle: nil)

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        let urlRef: StorageReference = Storage.storage().reference(forURL: event.photoURL)
            urlRef.getData(maxSize: 1000*1000) { data, error in
                if let error = error {
                    print("Error: \(error)")
                } else {
                    self.imageView.image = UIImage(data: data!)
                }
            }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
