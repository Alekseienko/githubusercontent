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
        // Create a URL from the provided string
        guard let imageURL = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }

        // Create a data task to fetch the image data from the URL
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let data = data {
                // Create a UIImage from the downloaded data
                if let image = UIImage(data: data) {
                    // Update the UI on the main thread
                    DispatchQueue.main.async {
                        // Set the image of the UIImageView
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


extension UILabel {
    var numberOfVisibleLines: Int {
        let textSize = CGSize(width: self.bounds.width, height: CGFloat(MAXFLOAT))
        let textRect = self.text?.boundingRect(with: textSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: self.font as Any], context: nil)
        if let rect = textRect {
            let numberOfLines = Int(rect.height / self.font.lineHeight)
            return numberOfLines
        }
        return 0
    }
}
