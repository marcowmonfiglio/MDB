//
//  SFSCollectionCell.swift
//  SFSCollectionCell
//
//  Created by Michael Lin on 9/26/21.
//

import UIKit

//In order to have dynamically scrolling, the cells have to be doubly linked lists, which means that the top cells are discarded and the bottom cells coming in are configured
class SFSCollectionCell: UICollectionViewCell {
    // TODO: Cell
    
    var symbol: SFSymbol? {
        didSet{
            //imageView.image = symbol?.image
            //titleView.title = symbol?.title
            
        }
    }
    
    //Image View
    //private let imageView
    
    //Title View
    //private let titleView
    
    //Initializer
    
    
}
