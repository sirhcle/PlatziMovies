//
//  CreditsMovieModel.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import Foundation

// MARK: - CreditsMovieModel
struct CreditsMovieModel: Codable {
    var id: Int?
    var cast, crew: [Cast]?
}

// MARK: - Cast
struct Cast: Codable {
    var adult: Bool?
    var gender, id: Int?
    var knownForDepartment: String?
    var name, originalName: String?
    var popularity: Double?
    var profilePath: String?
    var castID: Int?
    var character, creditID: String?
    var order: Int?
    var department: String?
    var job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}



