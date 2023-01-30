//
//  ShowVideoModel.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import Foundation

// MARK: - ShowVideoModel
struct ShowVideoModel: Codable {
    var id: Int?
    var results: [ResultVideoModel]?
}

// MARK: - Result
struct ResultVideoModel: Codable {
    var iso639_1: String?
    var iso3166_1: String?
    var name, key: String?
    var site: String?
    var size: Int?
    var type: String?
    var official: Bool?
    var publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}


