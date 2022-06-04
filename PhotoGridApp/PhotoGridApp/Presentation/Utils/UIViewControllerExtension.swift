//
//  ViewControllerExtension.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import UIKit

extension UIViewController {
    func simpleAlert(
        message: String,
        title: String = "Mensaje",
        buttonText: String = "Aceptar",
        completion: @escaping (UIAlertAction) -> Void) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: completion))
            self.show(alert, sender: nil)
        }
}
