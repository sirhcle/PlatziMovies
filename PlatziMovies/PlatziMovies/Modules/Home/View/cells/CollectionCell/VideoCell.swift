//
//  VideoCell.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 28/01/23.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    var upcomingMoviesResults: ResultUpcomingMovies = ResultUpcomingMovies()
    
    let imageView: CustomImageView = {
        let imageView = CustomImageView(frame: CGRect.zero)
        imageView.image = UIImage(named: "poster1-horizontal")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum Dolor sit a met Lorem ipsum Dolor sit a met Lorem ipsum Dolor sit a met"
        label.font = UIFont(name: "Helvetica-Bold", size: 14)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let lblSubtitle: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum"
        label.font = UIFont(name: "Helvetica", size: 12)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let imageBtnPlay: UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.image = UIImage(named: "btn-play")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let containerView: UIView = {
        let view = UIView(frame: CGRect.zero)
        view.backgroundColor = .black
        view.alpha = 0.4
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(upcomingMoviesResults: ResultUpcomingMovies) {
        
        self.upcomingMoviesResults = upcomingMoviesResults
        
        let domainImage: EndPoint = EndPoint(Domain: .images, ImageType: .horizontal_w710_h400)
        let pathImage = "\(domainImage.getImageURL())\(self.upcomingMoviesResults.posterPath ?? "")"
        self.imageView.loadImage(from: pathImage)
        
        self.lblTitle.text = self.upcomingMoviesResults.originalTitle
        self.lblSubtitle.text = self.upcomingMoviesResults.title
        
        self.addSubview(self.imageView)
        self.addSubview(self.containerView)
        self.addSubview(self.lblTitle)
        self.addSubview(self.lblSubtitle)
        self.addSubview(self.imageBtnPlay)
        
        self.layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.imageView.heightAnchor.constraint(equalToConstant: 225),
            
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.containerView.heightAnchor.constraint(equalToConstant: 225),
            
            self.lblTitle.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 15),
            self.lblTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.lblTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            self.lblSubtitle.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 10),
            self.lblSubtitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.lblSubtitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            
            self.imageBtnPlay.heightAnchor.constraint(equalToConstant: 40),
            self.imageBtnPlay.widthAnchor.constraint(equalToConstant: 40),
            self.imageBtnPlay.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor),
            self.imageBtnPlay.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor)
            
            
        ])
    }
    
}
