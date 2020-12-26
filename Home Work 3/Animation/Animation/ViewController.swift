//
//  ViewController.swift
//  Animation
//
//  Created by Dmytro Yurchenko on 24.12.20.
//

import UIKit

class ViewController: UIViewController {
     
     @IBOutlet weak var resizingView: UIView!
     @IBOutlet weak var circleView: UIView!
     @IBOutlet weak var colorView: UIView!
     @IBOutlet weak var circles: UIView!
     @IBOutlet weak var circle1: UIView!
     @IBOutlet weak var circle3: UIView!
     private var circleColor: UIView!
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
     }
     
     override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          
          let colors = [UIColor.yellow, UIColor.orange, UIColor.red, UIColor.blue, UIColor.green, UIColor.purple]

          circleColor = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
          circleColor.frame.size = CGSize(width: 100, height: 100)
          circleColor.frame.origin = CGPoint(x: 50, y: 50)
          circleColor.backgroundColor = .white
          circleColor.layer.cornerRadius = 50
          colorView.addSubview(circleColor)
          
          circle1.layer.cornerRadius = 50
          circle3.layer.cornerRadius = 50
          

          UIView.transition(with: self.resizingView, duration: 1.0, options: [.curveLinear], animations: {
               self.resizingView.transform = CGAffineTransform(translationX: -33/2, y: -33/2)
               self.resizingView.frame.size.height = 133
               self.resizingView.frame.size.width = 133
          }, completion: nil)
          
          UIView.transition(with: self.circleView, duration: 1.0, options: [.curveLinear], animations: {
               self.circleView.layer.cornerRadius = 50
          }, completion: nil)
          
          var c = 0
          Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) {
               timer in
               self.colorView.backgroundColor = colors[c]
               self.circleColor.backgroundColor = colors.reversed()[c]
               c += 1
               if c == colors.count {
                    timer.invalidate()
                    self.colorView.backgroundColor = .systemYellow
                    self.circleColor.backgroundColor = .white
               }
          }
          
          UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveLinear, .autoreverse, .repeat], animations: {
               self.circles.transform = CGAffineTransform(rotationAngle: .pi)
          }, completion: nil)
          
     }

}

