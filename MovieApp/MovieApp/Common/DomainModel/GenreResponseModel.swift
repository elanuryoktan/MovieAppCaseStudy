//
//  GenreResponseModel.swift
//  MovieApp
//
//  Created by Elanur Yoktan on 21.01.2024.
//

import Foundation

struct GenreResponseModel: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
}
