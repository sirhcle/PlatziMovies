//
//  DetailMovieViewController.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import UIKit

class DetailMovieViewController: UIViewController {

    var imgPath: String = ""
    var detailText: String = ""
    var idMovie: String = ""
    
    var detailView: DetailMoviewView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        self.detailView = DetailMoviewView(imgPath: self.imgPath, detailText: self.detailText)
        self.detailView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.idMovie = self.idMovie
        
        self.view.addSubview(self.detailView)
        self.layoutComponents(view: self.detailView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.detailView.setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
}
