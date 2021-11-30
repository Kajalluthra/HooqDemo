//
//  Results.swift
//  HooqDemo
//
//  Created by Kajal on 1/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation

struct Results: Decodable {
    var movies: [MovieList]
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case count = "total_pages"
    }
}

struct MovieList: Decodable {
    var title: String?
    var id : Int?
    var path : String?
    var overview : String?
    var date : String?
    
    enum CodingKeys: String, CodingKey {
        case title, id, overview
        case path = "poster_path"
        case date = "release_date"
    }
}
