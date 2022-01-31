//
//  UIView+Extensions.swift
//  Todo
//
//  Created by Decagon on 1/10/22.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func checkBox(_ imageName: String) -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(systemName: imageName)
        image.tintColor = .black
        return image
    }
    
    func setBack(navigationController: UINavigationController) {
        let navBar = navigationController.navigationBar
        navBar.scrollEdgeAppearance =  UINavigationBarAppearance()
        navBar.backgroundColor = .lightGray.withAlphaComponent(0.2)
    
    }
    
}
