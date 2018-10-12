//
//  MarsImageFetchOperation.swift
//  Astronomy
//
//  Created by Scott Bennett on 10/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PhotoFetchOperation: ConcurrentOperation
{
    var photoRef: MarsPhotoReference
    var image: UIImage?
    
    var task: URLSessionDataTask?
    
    init(_ photo: MarsPhotoReference) {
        photoRef = photo
        super.init()
    }
    override func start() {
        state = .isExecuting
        task = URLSession.shared.dataTask(with: photoRef.imageURL.usingHTTPS!) { data, _, error in
            if let error = error {
                NSLog("There was an error: \(error)");
            }
            
            guard let data = data else {
                NSLog("There was an error: no data");
                return
            }
            
            if let image = UIImage(data:data) {
                self.image = image
                self.state = .isFinished
                self.completionBlock?()
            }
        }
        task?.resume()
    }
    
    override func cancel() {
        task?.cancel()
    }
}
