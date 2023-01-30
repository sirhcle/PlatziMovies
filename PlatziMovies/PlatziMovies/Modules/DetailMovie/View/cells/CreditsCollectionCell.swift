//
//  CreditsCollectionCell.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import UIKit

class CreditsCollectionCell: UICollectionViewCell {
    
    var castMovie: Cast = Cast()
    
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
    
    let lblMovieCast: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Bold", size: 17)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = "Lorem ipsum dolor sit at met"
        label.textAlignment = .center
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
    func setupCell(castMovie: Cast) {
        self.castMovie = castMovie
        
        let domainImage: EndPoint = EndPoint(Domain: .images, ImageType: .vertical_w440_h660)
        let pathImage = "\(domainImage.getImageURL())\(self.castMovie.profilePath ?? "")"

        self.imageView.loadImage(from: pathImage)
        self.lblMovieCast.text = self.castMovie.name
        
        self.addSubview(self.imageView)
        self.addSubview(self.viewCover)
        self.addSubview(self.lblMovieCast)
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
            
            self.lblMovieCast.topAnchor.constraint(equalTo: self.viewCover.bottomAnchor),
            self.lblMovieCast.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            self.lblMovieCast.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            self.lblMovieCast.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
