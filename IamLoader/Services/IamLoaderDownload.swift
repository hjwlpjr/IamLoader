//
//  IamLoaderDownload.swift
//  IamLoader
//
//  Created by Andy on 11/08/19.
//  Copyright © 2019 Andy Wijaya. All rights reserved.
//

import Foundation

public class IamLoaderDownload: NSObject {
    
    public var downloadedUrl: URL?
    
    public override init() {
        super.init()
    }
    
    public func downloadPDF(url: String, completion: @escaping(Bool) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        urlSession.downloadTask(with: url) { (url, res, err) in
            if let err = err {
                print("there is err: " + err.localizedDescription)
                completion(false)
            }
            
            completion(true)
        }
    }
}

extension IamLoaderDownload: URLSessionDownloadDelegate {
    
    public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            downloadedUrl = destinationURL
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
    
}
