//
//  SmallCell.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 27/01/23.
//

import UIKit

class SmallCell: UICollectionViewCell {
    
    var trendingMoviesResults: ResultTrending = ResultTrending()
    
    let imageView: CustomImageView = {
        let imageView = CustomImageView(frame: CGRect.zero)
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum Dolor sit a met"
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lblDate: UILabel = {
        let label = UILabel()
        label.text = "19 Ene 2023"
        label.font = UIFont(name: "Helvetica", size: 12)
        label.textColor = .white
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(trendingMoviesResults: ResultTrending) {
        self.trendingMoviesResults = trendingMoviesResults
        
        let domainImage: EndPoint = EndPoint(Domain: .images, ImageType: .vertical_w440_h660)
        let pathImage = "\(domainImage.getImageURL())\(self.trendingMoviesResults.posterPath ?? "")"
        
        self.imageView.loadImage(from: pathImage)
        self.lblTitle.text = self.trendingMoviesResults.originalTitle
        self.lblDate.text = self.trendingMoviesResults.releaseDate
        
        self.addSubview(self.imageView)
        self.addSubview(self.lblTitle)
        self.addSubview(self.lblDate)
        self.layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.imageView.heightAnchor.constraint(equalToConstant: 225),
            
            self.lblTitle.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 15),
            self.lblTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.lblTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            self.lblDate.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 10),
            self.lblDate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.lblDate.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
        ])
    }
    
}
