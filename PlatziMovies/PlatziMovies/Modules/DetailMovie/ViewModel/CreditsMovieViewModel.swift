//
//  CreditsMovieViewModel.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import Foundation

class CreditsMovieViewModel {
    var creditsMovieBind = { (response: CreditsMovieModel) -> Void in }
    var creditsMovieModel: CreditsMovieModel = CreditsMovieModel() {
        didSet {
            creditsMovieBind(self.creditsMovieModel)
        }
    }
    
    func getCreditsMovieAsynckAwait(idVideo: String) {
        let endPoint = EndPoint(Domain: .theMovieDB, APIKey: .apiKeyMovieDB, Service: .creditsMovie(idVideo), Method: .GET)
        Task {
            do {
                let results = try await ApiManager().getData(for: endPoint, responseModel: CreditsMovieModel.self)
                
                switch results {
                case .success(let data):
                    self.creditsMovieModel = data
                default:
                    break
                }
                
            } catch {
                print("error")
            }
        }
    }
}
