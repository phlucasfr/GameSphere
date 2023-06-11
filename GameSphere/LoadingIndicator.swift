//
//  LoadingIndicator.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 11/06/23.
//

import UIKit

struct LoadingIndicator {
    private static var activityIndicator: UIActivityIndicatorView?
    
    static func showLoadingIndicator(in view: UIView) {
        
        if let indicator = activityIndicator {
            indicator.startAnimating()
            return
        }
          
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = view.center
        indicator.startAnimating()
              
        view.addSubview(indicator)
        activityIndicator = indicator
    }
    
    static func hideLoadingIndicator() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}

