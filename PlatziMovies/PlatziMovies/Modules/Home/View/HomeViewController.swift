//
//  HomeViewController.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 27/01/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeView.translatesAutoresizingMaskIntoConstraints = false
        self.homeView.delegate = self
        self.view.addSubview(self.homeView)
        self.layoutComponents(view: self.homeView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func selectedMovieNowPlaying(selectedMovie: ResultsNowPlaying) {
        let detailMoviewVC = DetailMovieViewController()
        detailMoviewVC.detailText = selectedMovie.overview ?? ""
        detailMoviewVC.imgPath = selectedMovie.posterPath ?? ""
        detailMoviewVC.idMovie = "\(selectedMovie.id ?? 0)"
        self.navigationController?.pushViewController(detailMoviewVC, animated: true)
    }
    
    func selectedMovieTrending(selectedMovie: ResultTrending) {
        let detailMoviewVC = DetailMovieViewController()
        detailMoviewVC.detailText = selectedMovie.overview ?? ""
        detailMoviewVC.imgPath = selectedMovie.posterPath ?? ""
        detailMoviewVC.idMovie = "\(selectedMovie.id ?? 0)"
        self.navigationController?.pushViewController(detailMoviewVC, animated: true)
    }
    
    func selectedMovieUpcoming(selectedMovie: ResultUpcomingMovies) {
        
        let showVideoVC = ShowVideoViewController()
        showVideoVC.idVideo = "\(selectedMovie.id ?? 0)"
        self.navigationController?.pushViewController(showVideoVC, animated: true)
    }
}
