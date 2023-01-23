//
//  SplashViewController.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2023-01-22.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

            guard let window = appDelegate.window else {
                appDelegate.window?.rootViewController = UIStoryboard(name: "HeroLayout", bundle: nil).instantiateViewController(withIdentifier: "HeroNavigation")
                appDelegate.window?.makeKeyAndVisible()
                return
            }

            window.rootViewController = UIStoryboard(name: "HeroLayout", bundle: nil).instantiateViewController(withIdentifier: "HeroNavigation")
            window.makeKeyAndVisible()
            UIView.transition(with: window,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
