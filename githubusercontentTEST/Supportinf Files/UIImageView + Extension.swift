//
//  UIImageView + Extension.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                        completion(image)
                    }
                } else {
                    print("Failed to create UIImage from data")
                    completion(nil)
                }
            } else if let error = error {
                print("Error fetching image data: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
