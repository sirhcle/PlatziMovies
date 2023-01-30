//
//  Configuration.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 27/01/23.
//

import Foundation

enum ImageType: String {
    case none = ""
    case vertical_w440_h660 = "w440_and_h660_face"
    case horizontal_w710_h400 =  "w710_and_h400_multi_faces"
    case original = "original"
}

enum Domain: String {
    case none = ""
    case theMovieDB = "https://api.themoviedb.org/3/"
    case images = "https://image.tmdb.org/t/p/"
}

enum APIKey: String {
    case none = ""
    case apiKeyMovieDB = "e88852d94a02ca0cdf8616e4b2443eeb"
}

enum Service {
    
    case none
    case trending
    case upcoming
    case popular
    case nowPlaying
    case videoOfMovie(String)
    case creditsMovie(String)
    
    var rawValue: String {
        
        switch self {
        case .none:
            return ""
        case .trending:
            return "trending/movie/week"
        case .upcoming:
            return "movie/upcoming"
        case .popular:
            return "movie/popular"
        case .nowPlaying:
            return "movie/now_playing"
        case .videoOfMovie(let idVideo):
            return "movie/\(idVideo)/videos"
        case .creditsMovie(let idMovie):
            return "movie/\(idMovie)/credits"
        }
    }
}

enum Method: String {
    case none = ""
    case GET = "GET"
}

struct EndPoint {
    
    var Domain: Domain = .none
    var APIKey: APIKey = .none
    var Service: Service = .none
    var Method: Method = .none
    var ImageType: ImageType = .none
    
    
    init(Domain: Domain, APIKey: APIKey, Service: Service, Method: Method) {
        self.Domain = Domain
        self.APIKey = APIKey
        self.Service = Service
        self.Method = Method
    }
    
    init(Domain: Domain, ImageType: ImageType) {
        self.Domain = Domain
        self.ImageType = ImageType
    }
    
    func getURL() -> String {
        return "\(self.Domain.rawValue)\(self.Service.rawValue)?api_key=\(self.APIKey.rawValue)&language=en"
    }
    
    func getImageURL() -> String {
        return "\(self.Domain.rawValue)\(self.ImageType.rawValue)"
    }
}
