//
//  LargeTableCell.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 28/01/23.
//

import UIKit

protocol LargeTableCellProtocol {
    func selectedMovie(movie: ResultsNowPlaying)
}

class LargeTableCell: UITableViewCell {
    
    var nowPlayingModel: NowPlayingModel = NowPlayingModel()
    var delegate: LargeTableCellProtocol!
    
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
    
    func setupCell(nowPlayingModel: NowPlayingModel) {
        
        self.nowPlayingModel = nowPlayingModel
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 250, height: 500)
        layout.scrollDirection = .horizontal

        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(LargeCell.self, forCellWithReuseIdentifier: "LargeCell")

        self.collectionView.backgroundColor = Colors().platziBackground
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

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

extension LargeTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nowPlayingModel.results?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeCell", for: indexPath) as! LargeCell
        
        if let result = self.nowPlayingModel.results {
            myCell.setupCell(nowPlayingResults: result[indexPath.row])
        }
        
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let results = self.nowPlayingModel.results {
            let selectedMovie = results[indexPath.row]
            
            if let delegate = self.delegate{
                delegate.selectedMovie(movie: selectedMovie)
            }
        }
    }
}
