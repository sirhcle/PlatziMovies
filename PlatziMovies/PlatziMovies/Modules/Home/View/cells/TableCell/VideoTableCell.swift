//
//  VideoTableCell.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 28/01/23.
//

import UIKit

protocol VideoTableCellProtocol {
    func selectedMovie(movie: ResultUpcomingMovies)
}

class VideoTableCell: UITableViewCell {

    //Models
    var upcomingMoviesModel: UpcomingMoviesModel = UpcomingMoviesModel()
    var delegate: VideoTableCellProtocol!
    
    //MARK: - UI Elements
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        return collectionView
    }()
    
    lazy var label: UILabel = {
       return UILabel()
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Setup
    func setupCell(upcomingMoviesModel: UpcomingMoviesModel) {
        
        self.upcomingMoviesModel = upcomingMoviesModel
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 250, height: 350)
        layout.scrollDirection = .horizontal
        //layout.estimatedItemSize = CGSize(width: 1, height: 1)
        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.contentOffset = CGPoint(x: 0, y: 0)
        self.collectionView.backgroundColor = Colors().platziBackground
        
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

//MARK: - Extensions
extension VideoTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.upcomingMoviesModel.results?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        if let results = self.upcomingMoviesModel.results {
            myCell.setupCell(upcomingMoviesResults: results[indexPath.row])
        }
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let results = self.upcomingMoviesModel.results {
            let selectedMovie = results[indexPath.row]
            
            if let delegate = self.delegate{
                delegate.selectedMovie(movie: selectedMovie)
            }
        }
    }
}
