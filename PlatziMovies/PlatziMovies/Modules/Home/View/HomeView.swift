//
//  HomeView.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 27/01/23.
//

import Foundation
import UIKit

protocol HomeViewProtocol {
    func selectedMovieUpcoming(selectedMovie: ResultUpcomingMovies)
    func selectedMovieNowPlaying(selectedMovie: ResultsNowPlaying)
    func selectedMovieTrending(selectedMovie: ResultTrending)
}

class HomeView: UIView {
    
    //View Model
    var homeViewModel: HomeViewModel = HomeViewModel()
    
    //Models
    var nowPlayingModel:     NowPlayingModel     = NowPlayingModel()
    var trendinMoviesModel:  TrendingMoviesModel = TrendingMoviesModel()
    var upcomingMoviesModel: UpcomingMoviesModel = UpcomingMoviesModel()
    
    
    //Delegates
    var delegate: HomeViewProtocol!
    
    //MARK: - UI Elements
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        return tableView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    //MARK: - Private functions
    private func setupView() {
        
        self.tableView.register(LargeTableCell.self, forCellReuseIdentifier: "LargeTableCell")
        self.tableView.register(SmallTableCell.self, forCellReuseIdentifier: "SmallTableCell")
        self.tableView.register(VideoTableCell.self, forCellReuseIdentifier: "VideoTableCell")
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = Colors().platziBackground
        self.addSubview(tableView)
        self.layoutComponets()
        
        self.setupData()
    }
    
    private func setupData() {
        self.homeViewModel.getNowPlaying()
        self.homeViewModel.getTrendingsAsyncAwait()
        self.homeViewModel.getUpcomingMovies()
        self.bindData()
    }
    
    private func bindData() {
        
        self.homeViewModel.nowPlayingBind = { [weak self] (data) in
            self?.nowPlayingModel = data
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: UITableView.RowAnimation.none)
            }
        }
        
        self.homeViewModel.trendingMoviesBind = { [weak self] (data) in
            self?.trendinMoviesModel = data
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(arrayLiteral: 1), with: UITableView.RowAnimation.none)
            }
        }
        
        self.homeViewModel.upcomingMoviesBind = { [weak self] (data) in
            self?.upcomingMoviesModel = data
            DispatchQueue.main.async {
                self?.tableView.reloadSections(IndexSet(arrayLiteral: 2), with: UITableView.RowAnimation.none)
            }
        }
    }
    
    private func layoutComponets() {
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return self.nowPlayingModel.results?.count != 0 ? 1 : 0
        case 1:
            return self.trendinMoviesModel.results?.count != 0 ? 1 : 0
            
        case 2:
            return self.upcomingMoviesModel.results?.count != 0 ? 1 : 0
            
        default:
            return 0
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LargeTableCell", for: indexPath) as! LargeTableCell
            if self.nowPlayingModel.results != nil {
                cell.setupCell(nowPlayingModel: self.nowPlayingModel)
                cell.delegate = self
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallTableCell", for: indexPath) as! SmallTableCell
            if self.trendinMoviesModel.results != nil {
                cell.setupCell(trendingMoviesModel: self.trendinMoviesModel)
                cell.delegate = self
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableCell", for: indexPath) as! VideoTableCell
            if self.upcomingMoviesModel.results != nil {
                cell.setupCell(upcomingMoviesModel: self.upcomingMoviesModel)
                cell.delegate = self
            }
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallTableCell", for: indexPath) as! SmallTableCell
            if self.trendinMoviesModel.results != nil {
                cell.setupCell(trendingMoviesModel: self.trendinMoviesModel)
                cell.delegate = self
            }
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 550
        case 1:
            return 350
        case 2:
            return 350
        default:
            return 350
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 10, y: 5, width: self.frame.size.width - 20, height: 40))
        view.backgroundColor = Colors().platziBackground
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: self.frame.size.width - 20, height: 40))
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        
        switch section {
        case 0:
            label.text = "Now Playing"
            break
        case 1:
            label.text = "Trending"
            break
        case 2:
            label.text = "Videos"
            break
        default:
            break
        }
        
        view.addSubview(label)
        return view
    }
}

extension HomeView: VideoTableCellProtocol {
    func selectedMovie(movie: ResultUpcomingMovies) {
        if let delegate = self.delegate {
            delegate.selectedMovieUpcoming(selectedMovie: movie)
        }
    }
}

extension HomeView: SmallTableCellProtocol {
    func selectedMovie(movie: ResultTrending) {
        
        if let delegate = self.delegate {
            delegate.selectedMovieTrending(selectedMovie: movie)
        }
    }
}

extension HomeView: LargeTableCellProtocol {
    func selectedMovie(movie: ResultsNowPlaying) {
        if let delegate = self.delegate {
            delegate.selectedMovieNowPlaying(selectedMovie: movie)
        }
    }
}
