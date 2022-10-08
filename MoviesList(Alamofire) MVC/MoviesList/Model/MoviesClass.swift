//
//  MoviesClass.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import Foundation

class Movie: Codable {
    var film_id: String?
    var film_ad: String?
    var film_yil: String?
    var film_resim: String?
    var kategori: Category?
    var yonetmen: Director?
    
    init() {
        
    }
    
    init(film_id: String, film_ad: String, film_yil: String, film_resim: String, kategori: Category, yonetmen: Director) {
        self.film_id = film_id
        self.film_ad = film_ad
        self.film_yil = film_yil
        self.film_resim = film_resim
        self.kategori = kategori
        self.yonetmen = yonetmen
    }
    
}
