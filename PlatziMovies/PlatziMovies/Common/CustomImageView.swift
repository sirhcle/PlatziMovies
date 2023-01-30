//
//  CustomImageView.swift
//  PlatziMovies
//
//  Created by christian hernandez rivera on 29/01/23.
//

import Foundation
import UIKit


let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var task: URLSessionDataTask!
    
    func loadImage(from url: String) {
        
        self.image = nil
        
        if let task = task {
            task.cancel()
        }
        
        if let url = URL(string: url) {
            
            if let imageCached = imageCache.object(forKey: url.absoluteURL as AnyObject) as? UIImage {
                self.image = imageCached
                return
            }
            
            task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let newImage = UIImage(data: data) else {
                    return
                }
                
                imageCache.setObject(newImage, forKey: url.absoluteURL as AnyObject)
                
                DispatchQueue.main.async {
                    self.image = newImage
                }
                
            }
            
            task.resume()
        }
    }
    
}
