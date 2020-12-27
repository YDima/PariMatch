//
//  DismissAnimationController.swift
//  Sports App
//
//  Created by Dmytro Yurchenko on 27.12.20.
//

import UIKit

class DismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
     
     func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
          return 1.0
     }
     
     func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
          
          guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
               return
          }
          
          let containerView = transitionContext.containerView
          containerView.insertSubview(toVC.view, at: 0)
          fromVC.view.isHidden = true
          
          let duration = transitionDuration(using: transitionContext)
          
          UIView.animate(
               withDuration: duration,
               animations: {
                    toVC.view.alpha = 0
                    toVC.view.transform = .identity
               },
               completion: { _ in
                    fromVC.view.isHidden = false
                    if transitionContext.transitionWasCancelled {
                         toVC.view.removeFromSuperview()
                    }
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
               }
          )
          
     }
     
}
