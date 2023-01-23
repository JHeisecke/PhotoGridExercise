//
//  AppDelegate.swift
//  PhotoGridApp
//
//  Created by Javier Heisecke on 2022-06-04.
//

import UIKit
import Sniffer
import Swinject
import SwinjectStoryboard

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var container: Container = {
        let container = Container()
        DIContainer.setup(container)
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Sniffer.register() // Register Sniffer to log all requests
        let window = UIWindow()
        window.makeKeyAndVisible()
        self.window = window

        let storyboard = SwinjectStoryboard.create(name: "HeroLayout", bundle: nil, container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()

        return true
    }
}
