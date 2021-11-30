//
//  LoadingView.swift
//  HooqDemo
//
//  Created by Kajal on 2/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import UIKit

final class LoadingView : UIView {
    
    @IBOutlet weak var activityView: UIView!
    class func newInstance() -> LoadingView {
        let nibs = Bundle.main.loadNibNamed("LoadingView", owner: nil, options: nil)! as [AnyObject]
        let loadingScreen = nibs.first as! LoadingView
        return loadingScreen
    }
    
    // MARK:- Handlers
    func show() {
        guard let window = UIApplication.shared.keyWindow else { return }
        self.frame = window.frame
        
        self.alpha = 0.0
        window.addSubview(self)
        UIView.animate(withDuration: GlobalConstants.loadingViewAnimation) {
            self.alpha = 1.0
        }
    }
    
    func hide() {
        UIView.animate(withDuration: GlobalConstants.loadingViewAnimation, delay: GlobalConstants.loadingViewDelay, options: .curveEaseIn, animations: {
                self.alpha = 0.0
        }, completion: { _ -> () in
            self.removeFromSuperview()
        })
    }
}
