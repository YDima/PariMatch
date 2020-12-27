//
//  SceneDelegate.swift
//  Sports App
//
//  Created by Dmytro Yurchenko on 24.12.20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

     var window: UIWindow?


     func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
          // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
          // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
          // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
          guard let _ = (scene as? UIWindowScene) else { return }
     }

     func sceneDidDisconnect(_ scene: UIScene) {
          // Called as the scene is being released by the system.
          // This occurs shortly after the scene enters the background, or when its session is discarded.
          // Release any resources associated with this scene that can be re-created the next time the scene connects.
          // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
     }

     func sceneDidBecomeActive(_ scene: UIScene) {
          self.window?.viewWithTag(12345)?.removeFromSuperview()
     }

     func sceneWillResignActive(_ scene: UIScene) {
          let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
          let blurEffectView = UIVisualEffectView(effect: blurEffect)
          blurEffectView.frame = window!.frame
          blurEffectView.tag = 12345

          self.window?.addSubview(blurEffectView)
     }

     func sceneWillEnterForeground(_ scene: UIScene) {
          self.window?.viewWithTag(12345)?.removeFromSuperview()
     }

     func sceneDidEnterBackground(_ scene: UIScene) {
          // Called as the scene transitions from the foreground to the background.
          // Use this method to save data, release shared resources, and store enough scene-specific state information
          // to restore the scene back to its current state.
     }


}

