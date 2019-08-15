//
//  IamLoaderImage.swift
//  IamLoader
//
//  Created by Andy on 09/08/19.
//  Copyright © 2019 Andy Wijaya. All rights reserved.
//

import UIKit

let cacheSize = 50
var imageCaches = [String: ImageCache]()

public class IamLoaderImage: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    public init() {
        super.init(frame: .zero)
        layer.masksToBounds = true
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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
        if let cachedImage = imageCaches[urlString] {
            // update number of count everytime cache used
            imageCaches[urlString]?.usedCount += 1
            self.image = cachedImage.image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        if url.absoluteString != self.lastURLUsedToLoadImage {
            return
        }
        
        let downloader = IamLoaderDownload()
        downloader.downloadData(apiUrl: urlString) { (res: Result<Data, RequestError>) in
            
            switch res {
            case .success(let res):
                let downloadedImage = UIImage(data: res)
                
                // do the removal least used cache if cache size already max
                if imageCaches.count >= cacheSize {
                    self.removeLeastUsedCache()
                }
                
                imageCaches[url.absoluteString] = ImageCache(image: downloadedImage ?? UIImage(), usedCount: 0)
                
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            case .failure(_):
                return
            }
        }
    }
    
    // this will remove least used cache
    func removeLeastUsedCache() {
        let usedCountArrays = imageCaches.map{$1}.map { (x) -> Int in
            x.usedCount
            }.sorted()
        
        let leastUsedDictionary = imageCaches.filter { (key, value) -> Bool in
            value.usedCount == usedCountArrays[0]
        }
        
        for (key, _) in leastUsedDictionary {
            imageCaches.removeValue(forKey: key)
        }
    }
}
