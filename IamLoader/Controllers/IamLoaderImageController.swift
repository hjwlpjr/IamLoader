//
//  ImageLoaderController.swift
//  IamLoader
//
//  Created by Andy on 11/08/19.
//  Copyright © 2019 Andy Wijaya. All rights reserved.
//

import UIKit

extension IamLoaderImage {
    
    public func resize(withSize: CGSize) {
        frame.size = withSize
    }
    
    public func makeShape(withShape: ImageShape = .rect, radiusForRound: CGFloat = 0) {
        switch withShape {
        case .rect:
            layer.cornerRadius = 0
        case .round:
            layer.cornerRadius = radiusForRound
        case .circle:
            layer.cornerRadius = frame.size.width / 2
        }
    }
    
    public func loadImage(urlString: String) {
        
        lastURLUsedToLoadImage = urlString
        
        // check for cached image to prevent refetch loaded image before
        if let cachedImage = imageCache[urlString] {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let downloadedImage = UIImage(data: imageData)
            imageCache[url.absoluteString] = downloadedImage
            
            DispatchQueue.main.async {
                self.image = downloadedImage
            }
        }).resume()
    }
}
