//
//  DirectorsClass.swift
//  MoviesList
//
//  Created by Hasan Esat Tozlu on 27.09.2022.
//

import Foundation

class Director: Codable {
    var yonetmen_id: String?
    var yonetmen_ad: String?
    
    init() {
        
    }
    
    init(yonetmen_id: String, yonetmen_ad: String) {
        self.yonetmen_id = yonetmen_id
        self.yonetmen_ad = yonetmen_ad
    }
}
