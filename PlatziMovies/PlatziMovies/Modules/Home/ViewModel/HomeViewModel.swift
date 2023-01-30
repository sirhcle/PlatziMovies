//
//  HomeViewModel.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 27/01/23.
//

import Foundation

class HomeViewModel {
    
    var nowPlayingBind = { (response: NowPlayingModel) -> Void in }
    var nowPlayingModel: NowPlayingModel = NowPlayingModel() {
        didSet {
            nowPlayingBind(self.nowPlayingModel)
        }
    }
    
    var trendingMoviesBind = { (response: TrendingMoviesModel) -> Void in }
    var trendingMoviesModel: TrendingMoviesModel = TrendingMoviesModel() {
        didSet {
            trendingMoviesBind(self.trendingMoviesModel)
        }
    }
    
    var upcomingMoviesBind = { (response: UpcomingMoviesModel) -> Void in }
    var upcomingMoviesModel: UpcomingMoviesModel = UpcomingMoviesModel() {
        didSet {
            upcomingMoviesBind(self.upcomingMoviesModel)
        }
    }
    
    
    func getNowPlaying() {
        let endPoint = EndPoint(Domain: .theMovieDB, APIKey: .apiKeyMovieDB, Service: .nowPlaying, Method: .GET)
        ApiManager().getData(for: endPoint) { (result: Result<NowPlayingModel, DataError>) in
            switch result {
            case .success(let data):
                self.nowPlayingModel = data
                break
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func getTrendingsAsyncAwait() {
        let endPoint = EndPoint(Domain: .theMovieDB, APIKey: .apiKeyMovieDB, Service: .trending, Method: .GET)
        Task {
            do {
                let results = try await ApiManager().getData(for: endPoint, responseModel: TrendingMoviesModel.self)
                
                switch results {
                case .success(let data):
                    self.trendingMoviesModel = data
                default:
                    break
                }
                
            } catch {
                print("error")
            }
        }
    }
    
    func getUpcomingMovies() {
        let endPoint = EndPoint(Domain: .theMovieDB, APIKey: .apiKeyMovieDB, Service: .upcoming, Method: .GET)
        ApiManager().getData(for: endPoint) { (result: Result<UpcomingMoviesModel, DataError>) in
            switch result {
            case .success(let data):
                self.upcomingMoviesModel = data
                break
                
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
