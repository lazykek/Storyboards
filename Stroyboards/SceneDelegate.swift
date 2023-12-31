//
//  SceneDelegate.swift
//  Stroyboards
//
//  Created by Ilya Cherkasov on 19.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "ViewControllerID"
        )
        // метод setValue(setValue:forUndefinedKey:) вызывается, когда не выходит найти ключ
        // Нужен ресерч доки
        // https://developer.apple.com/documentation/objectivec/nsobject/nskeyvaluecoding
        viewController.setValue("Hello World!", forKeyPath: "text")
        let window = UIWindow(windowScene: scene)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

