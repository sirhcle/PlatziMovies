//
//  DetailMoviewView.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import UIKit

class DetailMoviewView: UIView {

    var creditsMovieModel: CreditsMovieModel = CreditsMovieModel()
    var creditsMovieViewModel = CreditsMovieViewModel()
    
    var imgPath: String = ""
    var detailText: String = ""
    var idMovie: String = ""
    
    //MARK: - UI Elements
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        return collectionView
    }()
    
    lazy var imageView: CustomImageView = {
        let imageView = CustomImageView(frame: CGRect.zero)
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var lblMovieDetail: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = "Lorem ipsum dolor sit at met"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lblTitleCollection: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = "Cast"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    convenience init(imgPath: String, detailText: String) {
        self.init()
        self.imgPath = imgPath
        self.detailText = detailText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Public functions
    public func setupView() {
        let domainImage: EndPoint = EndPoint(Domain: .images, ImageType: .vertical_w440_h660)
        let pathImage = "\(domainImage.getImageURL())\(self.imgPath)"
        self.imageView.loadImage(from: pathImage)
        
        self.lblMovieDetail.text = self.detailText
        
        self.addSubview(self.imageView)
        self.addSubview(self.lblMovieDetail)
        
        
        self.setupCollection()
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.imageView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 10),
            self.imageView.widthAnchor.constraint(equalToConstant: 110),
            self.imageView.heightAnchor.constraint(equalToConstant: 200),
            
            self.lblMovieDetail.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.lblMovieDetail.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 10),
            self.lblMovieDetail.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10),
        ])
        
    }
    
    public func setupCollection() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150, height: 250)
        layout.scrollDirection = .horizontal

        self.collectionView.collectionViewLayout = layout
        self.collectionView.register(CreditsCollectionCell.self, forCellWithReuseIdentifier: "CreditsCollectionCell")

        self.collectionView.backgroundColor = .clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.addSubview(collectionView)
        self.addSubview(self.lblTitleCollection)
        self.layoutComponets()
        
        self.setupData()
    }
    
    //MARK: - Private functions
    private func setupData() {
        self.creditsMovieViewModel.getCreditsMovieAsynckAwait(idVideo: self.idMovie)
        self.bindData()
    }
    
    private func bindData() {
        self.creditsMovieViewModel.creditsMovieBind = { [weak self] (data) in
            
            DispatchQueue.main.async {
                self?.creditsMovieModel = data
                self?.collectionView.reloadData()
            }
            
        }
    }
    
    private func layoutComponets() {
        NSLayoutConstraint.activate([
            self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            self.collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 350),
            
            self.lblTitleCollection.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: 40),
            self.lblTitleCollection.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            self.lblTitleCollection.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            self.lblTitleCollection.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

}

extension DetailMoviewView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.creditsMovieModel.cast?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsCollectionCell", for: indexPath) as! CreditsCollectionCell
        
        if let result = self.creditsMovieModel.cast {
            myCell.setupCell(castMovie: result[indexPath.row])
        }
        
        return myCell
        
    }
}
