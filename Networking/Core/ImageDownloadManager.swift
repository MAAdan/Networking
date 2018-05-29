//
//  ImageDownloadManager.swift
//  Networking
//
//  Created by Miguel Angel Adan Roman on 29/5/18.
//  Copyright © 2018 Avantiic. All rights reserved.
//

import Foundation
import Alamofire

class ImageDownloadManager {
    let imageCacheFolder = "downloadedImages"
    
    open static let `default`: ImageDownloadManager = {
        // Set configuration parameters here if necessary
        
        return ImageDownloadManager()
    }()
    
    public init() {
        
    }
    
    func imageFor(url: URL) -> UIImage? {
        return UIImage(contentsOfFile: url.createPathForURLIn(folder: imageCacheFolder).path)
    }
    
    func downloadImageWith(url: URL, completionHandler: @escaping (_ image: UIImage?) -> Void) {
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        let destination = url.createFileDestinationForURLIn(folder: imageCacheFolder)
        
        Alamofire.download(request, to: destination).validate(statusCode: [200]).response(completionHandler: { (response) in

            if let imagePath = response.destinationURL?.path, response.error == nil {
                let image = UIImage(contentsOfFile: imagePath)
                completionHandler(image)
            } else if let destinationURL = response.destinationURL {
                do {
                    try FileManager.default.removeItem(at: destinationURL)
                } catch {
                    print("Could not remove file at destination: \(destinationURL)")
                }
            }
        })
    }
    
    func clearCache() {
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(imageCacheFolder).path
        do {
            let fileNames = try FileManager.default.contentsOfDirectory(atPath: documentsPath)
            
            for fileName in fileNames {
                let filePathName = "\(documentsPath)/\(fileName)"
                try FileManager.default.removeItem(atPath: filePathName)
            }
        } catch {
            print("Could not clear temp folder: \(error)")
        }
    }
}

extension URL {
    func createPathForURLIn(folder: String) -> URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(folder)
        return documentsURL.appendingPathComponent(self.lastPathComponent)
    }
    
    func createFileDestinationForURLIn(folder: String) -> DownloadRequest.DownloadFileDestination {
        return { _, response in
            print("statusCode: \(response.statusCode) \(response.url?.absoluteString)")
            
            let fileURL = self.createPathForURLIn(folder: folder)
            return (destinationURL: fileURL, options: [.removePreviousFile, .createIntermediateDirectories])
        }
    }
}
