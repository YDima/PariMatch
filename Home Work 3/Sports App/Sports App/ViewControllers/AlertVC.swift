//
//  AlertVC.swift
//  Sports App
//
//  Created by Dmytro Yurchenko on 27.12.20.
//

import UIKit

class AlertVC: UIViewController {
     
     @IBOutlet weak var alertView: UIView!
     @IBOutlet weak var bigTitle: UILabel!
     @IBOutlet weak var alertText: UITextView!
     @IBOutlet weak var okay: UIButton!
     
     @IBAction func okayAction(_ sender: UIButton) {
          self.dismiss(animated: true, completion: nil)
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          alertView.layer.cornerRadius = 13
          okay.layer.cornerRadius = 13
     }
     
}

