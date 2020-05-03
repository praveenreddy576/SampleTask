//
//  ImageView+Additions.swift
//  Task
//
//  Created by Praveen Reddy on 03/05/20.
//  Copyright © 2020 Praveen Reddy. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func downloadImage(_ url: String?) -> URLSessionDataTask? {
        
        guard let imageUrl = url else { return nil }
        
        guard let url = URL(string: imageUrl) else { return nil }

        // set initial image to nil so it doesn't use the image from a reused cell
        image = nil

        // check if the image is already in the cache
        if let imageToCache = imageCache.object(forKey: imageUrl as NSString) {
            self.image = imageToCache
            return nil
        }

        // download the image asynchronously
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err)
                return
            }

            DispatchQueue.main.async {
                // create UIImage
                let imageToCache = UIImage(data: data!)
                // add image to cache
                imageCache.setObject(imageToCache ?? UIImage(), forKey: imageUrl as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
        return task
    }
}

