//
//  UIAlertExtension.swift
//  HooqDemo
//
//  Created by Kajal on 1/3/2019.
//  Copyright © 2018 Kajal. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertPopUp(message: String) {
        let alertController = UIAlertController(title: GlobalConstants.appName, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: GlobalConstants.alertButtonTitle, style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}


