//
//  SceneDelegate.swift
//  PopMovies
//
//  Created by Angela Alves on 10/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCordinator: AppCordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let isDarkModeActive = UserDefaults.standard.bool(forKey: "isDarkMode")
        window.overrideUserInterfaceStyle = isDarkModeActive ? .dark : .light
        self.appCordinator = AppCordinator(window: window)
        appCordinator?.start()

        window.windowScene = windowScene
    }
}

