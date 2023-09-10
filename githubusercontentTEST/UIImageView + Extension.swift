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
    
    
    func isTextFit() -> Bool {
        if let labelText = text as? NSString, let labelFont = font {
            let labelWidth = frame.size.width
            let textSize = labelText.size(withAttributes: [NSAttributedString.Key.font: labelFont])
            return textSize.width <= labelWidth
        }
        return true // Враховуйте інші сценарії за замовчуванням
    }
    
    func isTextWrapped() -> Bool {
           if let labelText = text, let labelFont = font {
               let labelSize = CGSize(width: frame.size.width, height: .greatestFiniteMagnitude)
               let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
               let attributes: [NSAttributedString.Key: Any] = [.font: labelFont]
               let textRect = labelText.boundingRect(with: labelSize, options: options, attributes: attributes, context: nil)
               return textRect.height > frame.size.height
           }
           return false
       }
    
    func maxCharactersForTwoLines() -> Int {
        guard let labelText = text, let labelFont = font else {
            return 0
        }

        let labelWidth = frame.size.width
        let charSize = "X".size(withAttributes: [NSAttributedString.Key.font: labelFont])

        let maxCharsInOneLine = Int(labelWidth / charSize.width)
        return maxCharsInOneLine * 2
    }
}
