//
//  MoviesCollectionCell.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import UIKit

protocol MoviesCollectionCellProtocol {
    func addToCart(indexPath: IndexPath)
}

class MoviesCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var moviePriceLabel: UILabel!
    
    var cellProtocol: MoviesCollectionCellProtocol?
    var indexPath: IndexPath?
    
    
    @IBAction func addToCart(_ sender: Any) {
        
        cellProtocol?.addToCart(indexPath: indexPath!)
    }
}
