//
//  ViewController.swift
//  Circle Animation
//
//  Created by Dmytro Yurchenko on 24.12.20.
//

import UIKit

class ViewController: UIViewController {
     
     private var circle: UIView! {
          didSet {
               circle.isUserInteractionEnabled = true
               let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
               tapGestureRecognizer.numberOfTapsRequired = 1
               circle.addGestureRecognizer(tapGestureRecognizer)
               
               let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
               swipeUp.direction = .up
               circle.addGestureRecognizer(swipeUp)
               
               let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
               swipeLeft.direction = .left
               circle.addGestureRecognizer(swipeLeft)
               
               let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
               swipeRight.direction = .right
               circle.addGestureRecognizer(swipeRight)
               
               let swipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
               swipe.direction = .down
               circle.addGestureRecognizer(swipe)
               
               let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTap(_:)))
               doubleTapGestureRecognizer.numberOfTapsRequired = 2
               circle.addGestureRecognizer(doubleTapGestureRecognizer)
               
          }
     }
     
     @objc func didTap(_ sender: UITapGestureRecognizer) {
          UIView.transition(with: self.circle, duration: 1.5, options: [.curveLinear], animations: {
               self.circle.frame.origin = CGPoint(x: self.view.frame.size.width / 2 - 20, y: self.view.frame.size.height / 2 - 20)
          }, completion: nil)
          
     }
     
     @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
          let colors = [UIColor.yellow, UIColor.orange, UIColor.red, UIColor.blue, UIColor.green, UIColor.purple]
          let randomColor = colors.randomElement()!

          if sender.state == .ended {
               if sender.direction == .up {
                    UIView.transition(with: self.circle, duration: 1.5, options: [.curveLinear], animations: {
                         self.circle.backgroundColor = randomColor
                         self.circle.frame.origin = CGPoint(x: self.view.frame.size.width / 2 - 20, y: self.view.frame.size.height / 2 - 50)
                    }, completion: nil)
                    
               } else if sender.direction == .left {
                    UIView.transition(with: self.circle, duration: 1.5, options: [.curveLinear], animations: {
                         self.circle.backgroundColor = randomColor
                         self.circle.frame.origin = CGPoint(x: self.view.frame.size.width / 2 - 50, y: self.view.frame.size.height / 2 - 20)
                    }, completion: nil)
                    
               } else if sender.direction == .right {
                    UIView.transition(with: self.circle, duration: 1.5, options: [.curveLinear], animations: {
                         self.circle.backgroundColor = randomColor
                         self.circle.frame.origin = CGPoint(x: self.view.frame.size.width / 2 + 10, y: self.view.frame.size.height / 2 - 20)
                    }, completion: nil)
                    
               } else {
                    UIView.transition(with: self.circle, duration: 1.5, options: [.curveLinear], animations: {
                         self.circle.backgroundColor = randomColor
                         self.circle.frame.origin = CGPoint(x: self.view.frame.size.width / 2 - 20, y: self.view.frame.size.height / 2 + 10)
                    }, completion: nil)
               }
          }
     }
     
     @objc func didDoubleTap(_ sender: UITapGestureRecognizer) {
          UIView.transition(with: self.circle, duration: 1.5, options: [.curveLinear], animations: {
               self.circle.frame.origin = CGPoint(x: self.view.frame.size.width / 2 - 20, y: self.view.frame.size.height / 2 - 20)
               self.startAnimating()
          }, completion: nil)
          
     }
     
     func startAnimating() {
          let path = UIBezierPath()
          let initialPoint = CGPoint(x: self.view.frame.size.width / 2 - 20, y: self.view.frame.size.height / 2 - 20)
         path.move(to: initialPoint)

         for angle in -89...0 { path.addLine(to: self.getPoint(for: angle)) }
         for angle in 1...270 { path.addLine(to: self.getPoint(for: angle)) }

         path.close()

         self.animate(view: self.circle, path: path)
       }

       private func animate(view: UIView, path: UIBezierPath) {
         let animation = CAKeyframeAnimation(keyPath: "position")

         animation.path = path.cgPath

         animation.repeatCount = 1
         animation.duration = 3

         view.layer.add(animation, forKey: "animation")
       }

       private func getPoint(for angle: Int) -> CGPoint {
          let radius = 80.0

         let radian = Double(angle) * Double.pi / Double(180)

         let newCenterX = radius + radius * cos(radian)
         let newCenterY = radius + radius * sin(radian)

          return CGPoint(x: newCenterX + Double(self.view.frame.size.width) / 2 - 20, y: newCenterY + Double(self.view.frame.size.height / 2 - 20))
       }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
     }
     
     override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          
          circle = UIView(frame: CGRect(origin: CGPoint(x: view.frame.size.width / 2 - 20, y: view.frame.size.height / 2 - 20), size: CGSize(width: 40, height: 40)))
          circle.backgroundColor = .red
          circle.layer.cornerRadius = 20
          self.view.addSubview(circle)
     }

}

