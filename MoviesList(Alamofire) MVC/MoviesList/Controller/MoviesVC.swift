//
//  MoviesVC.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import UIKit
import Alamofire

class MoviesVC: UIViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    var movieList = [Movie]()
    var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self

        
        let design : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.movieCollectionView.frame.width
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidth = (width-30)/2
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.7)
        
        movieCollectionView.collectionViewLayout = design
        
        if let selectedCategory = selectedCategory {
            navigationItem.title = selectedCategory.kategori_ad
            
            if let category_id = selectedCategory.kategori_id {
                if let category_idInt = Int(category_id) {
                    getMoviesByCategoryId(category_id: category_idInt)
                }
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = sender as? Int {
            let selectedMovie = movieList[index]
            let destinationVC = segue.destination as! MovieDetailVC
            destinationVC.selectedMovie = selectedMovie
        }
    }
    
    func getMoviesByCategoryId(category_id: Int) {
        let parameters = ["kategori_id":category_id]
        AF.request("http://kasimadalan.pe.hu/filmler/filmler_by_kategori_id.php", method: .post, parameters: parameters).response { response in
            if let data = response.data {
                
                do {
                    let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    if let movies = moviesResponse.filmler {
                        self.movieList = movies
                    }
                    DispatchQueue.main.async {
                        self.movieCollectionView.reloadData()
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
    }

}

extension MoviesVC: UICollectionViewDelegate, UICollectionViewDataSource, MoviesCollectionCellProtocol {
    
    func addToCart(indexPath: IndexPath) {
        print("to Cart added movie: \(movieList[indexPath.row].film_ad!)")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movieList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCollectionCell", for: indexPath) as! MoviesCollectionCell
        
        cell.movieImageView.image = UIImage()
        if let url = URL(string: "http://kasimadalan.pe.hu/filmler/resimler/\(movie.film_resim!)") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.movieImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        cell.movieNameLabel.text = movie.film_ad
        cell.moviePriceLabel.text = "15.99₺"
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.5
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetails", sender: indexPath.row)
    }
    
    
}
