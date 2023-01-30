//
//  ShowVideoView.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import UIKit
import WebKit

class ShowVideoView: UIView {

    //MARK: viewModels
    let showVideoViewModel: ShowVideoViewModel = ShowVideoViewModel()
    
    //MARK: - Properties
    var videoKey: String!
    var videoID: String = ""
    
    //MARK: - ui elements
    var webView: WKWebView = {
        let webview = WKWebView(frame: .zero)
        return webview
    }()
    
    var videoView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    var lblError: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        return label
    }()
    
    //MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Setup and configurations
    public func setupView() {
        self.addSubview(self.videoView)
        
        self.layoutComponents()
        self.setupData()
    }
    
    func setupData() {
        self.showVideoViewModel.getVideoAsynckAwait(idVideo: self.videoID)
        self.bindData()
    }
    
    func bindData() {
        self.showVideoViewModel.showVideoBind = { [weak self] (data) in
            self?.videoKey = data.results?.first?.key
            
            

            DispatchQueue.main.async {

                if let videoKey = self?.videoKey {
                    
                    let webConfiguration = WKWebViewConfiguration()
                    webConfiguration.allowsInlineMediaPlayback = true
                    
                    self?.webView = WKWebView(frame: CGRect(x: 0, y: 10, width: 400, height: 250), configuration: webConfiguration)
                    
                    self?.videoView.addSubview(self!.webView)

                    guard let videoURL = URL(string: "https://www.youtube.com/embed/\(videoKey)?playsinline=1") else { return }
                    let request = URLRequest(url: videoURL)
                    self?.webView.load(request)
                }
            }
            
        }
    }
    
    func layoutComponents() {
        NSLayoutConstraint.activate([
            self.videoView.topAnchor.constraint(equalTo: self.topAnchor),
            self.videoView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.videoView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.videoView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        
        ])
    }
    
}



