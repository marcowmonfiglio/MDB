//
//  PokedexPreviewVC.swift
//  Pokedex
//
//  Created by Marco Monfiglio on 3/12/22.
//

import UIKit

class PokedexPreviewVC: UIViewController {
    
    private let imageView = UIImageView()

    override func viewDidLoad() {
        view.addSubview(imageView)
        let width = 400
        let height = 400
        preferredContentSize = CGSize(width: width, height: height)
    }
    
    override func viewDidLayoutSubviews() {
        imageView.frame = view.bounds.inset(by: UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10))
    }

    init(symbol: Pokemon) {
        super.init(nibName: nil, bundle: nil)

        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.tintColor = .white
        if let imageData = try? Data(contentsOf: symbol.imageUrl!) {
            if let currImage = UIImage(data: imageData) {
                imageView.image = currImage
                    }
                }
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
