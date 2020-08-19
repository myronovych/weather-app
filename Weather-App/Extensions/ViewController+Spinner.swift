//
//  ViewController+Spinner.swift
//  Weather-App
//
//  Created by rs on 19.08.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    func showSpinner() {
        print("Showing ai")
        DispatchQueue.main.async {
            aView = UIView(frame: self.view.bounds)
            aView?.backgroundColor = .gray
            
            let ai = UIActivityIndicatorView(style: .large)
            ai.center = aView!.center
            ai.startAnimating()
            aView?.addSubview(ai)
            
            self.view.addSubview(aView!)
            aView?.alpha = 0
            UIView.animate(withDuration: 0.2) {
                aView?.alpha = 1
            }
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            aView?.removeFromSuperview()
            aView = nil
        }
    }
}
