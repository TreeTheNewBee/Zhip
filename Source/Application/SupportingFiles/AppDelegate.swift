//
//  AppDelegate.swift
//  Zupreme
//
//  Created by Alexander Cyon on 2018-05-26.
//  Copyright © 2018 Open Zesame. All rights reserved.
//

import UIKit
import Zesame
import KeychainSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder {
    lazy var window: UIWindow? = .default

    private lazy var appCoordinator = AppCoordinator(window: window, services: DefaultUseCaseProvider.shared, securePersistence: KeyValueStore(KeychainSwift()))
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.start()

        IQKeyboardManager.shared.enable = true

        return true
    }
}
