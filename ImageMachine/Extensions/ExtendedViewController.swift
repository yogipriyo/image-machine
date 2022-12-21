//
//  ExtendedViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import UIKit

extension UIViewController {
    func displaySimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
