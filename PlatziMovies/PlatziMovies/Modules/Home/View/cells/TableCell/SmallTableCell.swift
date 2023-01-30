//
//  SmallTableCell.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 28/01/23.
//

import UIKit
protocol SmallTableCellProtocol {
    func selectedMovie(movie: ResultTrending)
}

class SmallTableCell: UITableViewCell {

    var trendingMoviesModel: TrendingMoviesModel = TrendingMoviesModel()
    var delegate: SmallTableCellProtocol!
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        return collectionView
    }()
    
    lazy var label: UILabel = {
       return UILabel()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(trendingMoviesModel: TrendingMoviesModel) {
        self.trendingMoviesModel = trendingMoviesModel
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 150, height: 350)
        layout.scrollDirection = .horizontal

        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(SmallCell.self, forCellWithReuseIdentifier: "SmallCell")

        self.collectionView.backgroundColor = Colors().platziBackground
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentOffset = CGPoint(x: 0, y: 0)

        self.addSubview(collectionView)
        self.layoutComponents()
    }
    
    func layoutComponents() {
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

extension SmallTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.trendingMoviesModel.results?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmallCell", for: indexPath) as! SmallCell
        
        if let results = self.trendingMoviesModel.results {
            myCell.setupCell(trendingMoviesResults: results[indexPath.row])
        }
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let results = self.trendingMoviesModel.results {
            let selectedMovie = results[indexPath.row]
            
            if let delegate = self.delegate{
                delegate.selectedMovie(movie: selectedMovie)
            }
        }
    }
}
