//
//  Extension.swift
//  Сats
//
//  Created by Головаш Анастасия on 13.05.2020.
//  Copyright © 2020 Anastasia. All rights reserved.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    
    /// Shows Activity Indicator.
    func showActivityIndicator() {
        aView = UIView(frame: self.view.bounds)

        let activityIndicator = UIActivityIndicatorView(style: .large)
        guard let centerX : CGFloat = aView?.center.x else { return }
        guard let centerY : CGFloat = aView?.center.y else { return }
        activityIndicator.center = CGPoint(x: centerX, y: centerY * 0.7)
        activityIndicator.startAnimating()
        aView?.addSubview(activityIndicator)
        self.view.addSubview(aView ?? UIView())
    }
    
    /// Removes Activity Indicator.
    func removeActivityIndicator() {
        aView?.removeFromSuperview()
        aView = nil
    }
    
}
