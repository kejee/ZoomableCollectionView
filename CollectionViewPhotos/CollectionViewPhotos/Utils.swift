//
//  Utils.swift
//  CollectionViewPhotos
//
//  Created by HYapple on 2024/4/22.
//

import UIKit

let kWidth: CGFloat = {
    if #available(iOS 13.0, *) {
        if let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let kWidth = currentScene.coordinateSpace.bounds.size.width
            return kWidth
        }
    }
    return UIScreen.main.bounds.size.width
}()

let kHeight = {
    if #available(iOS 13.0, *) {
        if let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let kHeight = currentScene.coordinateSpace.bounds.size.height
            return kHeight
        }
    }
    return UIScreen.main.bounds.size.height
}()


extension UIColor {
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}


