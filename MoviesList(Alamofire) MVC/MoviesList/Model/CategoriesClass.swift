//
//  CategoriesClass.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import Foundation

class Category: Codable {
    var kategori_id: String?
    var kategori_ad: String?
    
    init() {
        
    }
    
    init(kategori_id: String, kategori_ad: String) {
        self.kategori_id = kategori_id
        self.kategori_ad = kategori_ad
    }
}
