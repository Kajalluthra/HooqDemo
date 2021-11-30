//
//  NetworkService.swift
//  HooqDemo
//
//  Created by Kajal on 1/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation

class NetworkService {
    private struct Constant {
        static let baseURL = "https://api.themoviedb.org/3/movie/"
        static let apiKey = "6ea76afacd0f5eaf9787313abed241c4"
        static let langauge = "en-US"
    }
    
    func fetchAllMoviesApiRequest(_ pagelimit: Int, completion: @escaping (Result<Results, Error>) -> Void) {
        let urlString = "\(Constant.baseURL)now_playing?api_key=\(Constant.apiKey)&language=\(Constant.langauge)&page=\(pagelimit)"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> () in
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(Results.self, from: data)
                completion(.success(courses))
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }).resume()
    }
    
    func fetchSimilarMoviesApiRequest(_ id: Int, completion: @escaping (Result<Results, Error>) -> Void) {
        let urlString = "\(Constant.baseURL)\(id)/similar?api_key=\(Constant.apiKey)&language=\(Constant.langauge)&page=1"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> () in
            guard let data = data else { return }
            do {
                let courses = try JSONDecoder().decode(Results.self, from: data)
                completion(.success(courses))
            } catch let jsonErr {
                completion(.failure(jsonErr))
            }
        }).resume()
    }
}
