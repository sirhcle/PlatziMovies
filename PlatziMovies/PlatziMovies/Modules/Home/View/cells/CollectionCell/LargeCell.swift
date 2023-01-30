//
//  LargeCell.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 27/01/23.
//

import UIKit

class LargeCell: UICollectionViewCell {
    
    var nowPlayingResults: ResultsNowPlaying = ResultsNowPlaying()
    
    //MARK: - UI Elements
    let imgPoster : UIImage = {
        let image = UIImage(named: "poster1")
        return image!
    }()
    
    let imageView: CustomImageView = {
        let imageView = CustomImageView(frame: CGRect.zero)
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let viewCover : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblMovieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = "Lorem ipsum dolor sit at met"
        label.textAlignment = .center
        label.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: -
    func setupCell(nowPlayingResults: ResultsNowPlaying) {
        self.nowPlayingResults = nowPlayingResults
        
        self.imageView.image = self.imgPoster
        
        let domainImage: EndPoint = EndPoint(Domain: .images, ImageType: .vertical_w440_h660)
        let pathImage = "\(domainImage.getImageURL())\(self.nowPlayingResults.posterPath ?? "")"
        
        self.imageView.loadImage(from: pathImage)
        self.lblMovieTitle.text = self.nowPlayingResults.originalTitle
        
        self.addSubview(self.imageView)
        self.addSubview(self.viewCover)
        self.addSubview(self.lblMovieTitle)
        self.layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.viewCover.topAnchor.constraint(equalTo: self.topAnchor),
            self.viewCover.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.viewCover.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.viewCover.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.lblMovieTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            self.lblMovieTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            self.lblMovieTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            self.lblMovieTitle.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
