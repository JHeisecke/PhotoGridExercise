//
//  UImageViewExtension.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import UIKit

private let cache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadFrom(urlString: String) {

        guard let imageFromCache = cache.object(forKey: urlString as NSString) else {
            guard let url = URL(string: urlString) else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                if let imageData = try? Data(contentsOf: url) {
                    if let loadedImage = UIImage(data: imageData) {
                        cache.setObject(loadedImage, forKey: urlString as NSString)
                        self?.image = loadedImage
                    }
                }
            }
            return
        }

        self.image = imageFromCache
    }
}
