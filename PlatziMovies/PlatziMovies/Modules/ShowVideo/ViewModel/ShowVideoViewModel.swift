//
//  ShowVideoViewModel.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import Foundation

class ShowVideoViewModel {
    
    var showVideoBind = { (response: ShowVideoModel) -> Void in }
    var showVideoModel: ShowVideoModel = ShowVideoModel() {
        didSet {
            showVideoBind(self.showVideoModel)
        }
    }
    
    func getVideoAsynckAwait(idVideo: String) {
        let endPoint = EndPoint(Domain: .theMovieDB, APIKey: .apiKeyMovieDB, Service: .videoOfMovie(idVideo), Method: .GET)
        Task {
            do {
                let results = try await ApiManager().getData(for: endPoint, responseModel: ShowVideoModel.self)
                
                switch results {
                case .success(let data):
                    self.showVideoModel = data
                default:
                    break
                }
                
            } catch {
                print("error")
            }
        }
    }
    
}
