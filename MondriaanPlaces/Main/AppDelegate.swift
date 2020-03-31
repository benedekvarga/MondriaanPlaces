//
//  AppDelegate.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 28..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import GoogleMaps
import UIKit
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // MARK: - Google API Key

        GMSServices.provideAPIKey("AIzaSyAsHChBb3GpzfL4htCSlwGcEjlK3_u2szM")

        // MARK: - Dependency Injection

        DependencyInjection.shared.registerModules()

        // MARK: - Display first screen

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let viewController = DependencyInjection.shared.resolvePlaceListViewController().viewController
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController

        return true
    }

    // MARK: - UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
