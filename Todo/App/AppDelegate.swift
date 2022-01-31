//
//  AppDelegate.swift
//  Todo
//
//  Created by Decagon on 1/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var standard: AppDelegate { UIApplication.shared.delegate as? AppDelegate ?? AppDelegate.standard}

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}
