//
//  AlertSegue.swift
//  Sports App
//
//  Created by Dmytro Yurchenko on 28.12.20.
//

import UIKit

class AlertSegue: UIStoryboardSegue {
     
     override func perform() {
          destination.transitioningDelegate = self
          destination.modalPresentationStyle = .custom
          super.perform()
          source.present(destination, animated: true, completion: nil)
     }
     
}

extension AlertSegue: UIViewControllerTransitioningDelegate {
     func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
       return PresentAnimationController()
     }
}
