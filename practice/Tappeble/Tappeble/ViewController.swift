//
//  ViewController.swift
//  Tappeble
//
//  Created by Dmytro Yurchenko on 16.12.20.
//

import UIKit

class ViewController: UIViewController {
     
     @IBOutlet private var imageView: UIImageView! {
          didSet {
               imageView.isUserInteractionEnabled = true
               imageView.image = UIImage(named: "nhl-white")
               let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
               imageView.addGestureRecognizer(pinchGestureRecognizer)
          }
          
     }
     
     @objc func didTapImageView(_ sender: UIPinchGestureRecognizer) {
         print("did tap image view", sender)
     }

     override func viewDidLoad() {
          super.viewDidLoad()
          
     }
     
     override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(animated)
             
          UIView.transition(with: self.imageView, duration: 3.0, options: [.transitionCrossDissolve, .repeat, .autoreverse], animations: { self.imageView.image = UIImage(imageLiteralResourceName: "nhl") }, completion: nil)
          
     }

}

