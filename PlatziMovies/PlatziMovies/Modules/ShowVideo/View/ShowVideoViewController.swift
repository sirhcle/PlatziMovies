//
//  ShowVideoViewController.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import UIKit

class ShowVideoViewController: UIViewController {
    
    var idVideo = ""
    
    var showVideoView: ShowVideoView = ShowVideoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.showVideoView.translatesAutoresizingMaskIntoConstraints = false
        self.showVideoView.videoID = self.idVideo
        self.showVideoView.setupView()
        
        self.view.addSubview(self.showVideoView)
        
        self.layoutComponents(view: self.showVideoView)
        
        
    }
}
