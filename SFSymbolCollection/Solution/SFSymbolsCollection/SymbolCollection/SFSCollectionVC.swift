//
//  SFSCollectionVC.swift
//  SFSCollectionVC
//
//  Created by Michael Lin on 9/26/21.
//

import UIKit

class SFSCollectionVC: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SFSCollectionCell.self, forCellWithReuseIdentifier: SFSCollectionCell.reuseIdentifier) //The collection view has to know what type of cell is being passed;
        //Moves from collection view initiliazition (initializes the type of cell)
        //Goes to the data source to get configured with content
        //Goes to display, and is reused when no longer needed
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1B 1D 1F
        view.backgroundColor = #colorLiteral(red: 0.09803921569, green: 0.1058823529, blue: 0.1098039216, alpha: 1)
        
        view.addSubview(collectionView)
        collectionView.frame = view.bounds.inset(by: UIEdgeInsets(top: 88, left: 30, bottom: 0, right: 30))
        collectionView.backgroundColor = .clear
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.dataSource = self //This assigns SFSCollection to be the dataSource in order for collectionView to be able to ask for items
        collectionView.delegate = self //Both data source and delegate are part of the delegate design, but just have different names
    }
}

extension SFSCollectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SymbolProvider.symbols.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let symbol = SymbolProvider.symbols[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SFSCollectionCell.reuseIdentifier, for: indexPath) as! SFSCollectionCell
        cell.symbol = symbol
        return cell
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

extension SFSCollectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let symbol = SymbolProvider.symbols[indexPath.item]
        
        return UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
            return SFSPreviewVC(symbol: symbol)
        }) { _ in
            let okItem = UIAction(title: "OK", image: UIImage(systemName: "arrow.down.right.and.arrow.up.left")) { _ in }
            return UIMenu(title: "", image: nil, identifier: nil, children: [okItem])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let symbol = SymbolProvider.symbols[indexPath.item]
        print("Selected \(symbol.name)")
    }
}
