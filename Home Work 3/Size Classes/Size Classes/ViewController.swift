//
//  ViewController.swift
//  Size Classes
//
//  Created by Dmytro Yurchenko on 24.12.20.
//

import UIKit

class ViewController: UIViewController {
     
     @IBOutlet weak var view1: UIStackView!
     @IBOutlet weak var view3: UIStackView!
     @IBOutlet weak var redView: UIView!
     @IBOutlet weak var orangeView: UIView!
     @IBOutlet weak var greenView: UIView!
     @IBOutlet weak var purpleView: UIView!
     
     var isRegularHeight:Bool{
          return view.traitCollection.verticalSizeClass == .regular
     }
     var isRegularWidth:Bool{
          return view.traitCollection.horizontalSizeClass == .regular
     }
     
     func landscapeLayout(){
          view1.axis = .horizontal
          view3.axis = .horizontal
     }
     
     func portraitLayout(){
          view1.axis = .vertical
          view3.axis = .vertical
     }
     
     override func viewWillLayoutSubviews() {
          let iPad = UIDevice.current.userInterfaceIdiom == .pad
          let orientation = UIDevice.current.orientation
          if iPad && (orientation == .landscapeLeft)||(orientation == .landscapeRight) {
               if isRegularHeight && isRegularWidth {
                    landscapeLayout()
               } else {
                    portraitLayout()
               }
          } else {
               portraitLayout()
          }
     }
     
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          UIDevice.current.beginGeneratingDeviceOrientationNotifications()
          
     }
     
     override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          UIDevice.current.endGeneratingDeviceOrientationNotifications()
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          redView.layer.cornerRadius = 13
          orangeView.layer.cornerRadius = 13
          greenView.layer.cornerRadius = 13
          purpleView.layer.cornerRadius = 13
     }
     
}

