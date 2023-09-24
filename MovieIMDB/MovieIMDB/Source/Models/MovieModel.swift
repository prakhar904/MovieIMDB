//
//  MovieModel.swift
//  MovieIMDB
//
//  Created by Prakhar Garg on 24/09/23.
//

import Foundation

struct MovieResponse: Codable {
    let results: [MovieResult]
}

struct MovieResult: Codable {
    let title: String
    let posterPath: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}

struct MovieModel {
    let title: String
    let thumbnail: String
    let rating: Double
    var playlist: String?
}
