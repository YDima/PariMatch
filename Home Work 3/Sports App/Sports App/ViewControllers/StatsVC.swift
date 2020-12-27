//
//  StatsVC.swift
//  Sports App
//
//  Created by Dmytro Yurchenko on 27.12.20.
//

import UIKit

class StatsVC: UIViewController {
     
     @IBOutlet weak var image1: UIImageView!
     @IBOutlet weak var statsTitle1: UILabel!
     @IBOutlet weak var statsNumber1: UILabel!
     
     @IBOutlet weak var image2: UIImageView!
     @IBOutlet weak var statsTitle2: UILabel!
     @IBOutlet weak var statsNumber2: UILabel!
     
     var picture1: UIImage?
     var picture2: UIImage?
     var title1: String?
     var title2: String?
     var number1: String?
     var number2: String?
     
     @IBOutlet weak var check: UIButton!
     
     @IBAction func checkStats(_ sender: UIButton) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let alert = storyboard.instantiateViewController(withIdentifier: "alert")
          alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
          alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
          self.present(alert, animated: true, completion: nil)
//          self.performSegue(withIdentifier: "alert", sender: self)
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          check.layer.cornerRadius = 8
          image1.image = picture1
          image2.image = picture2
          statsTitle1.text = title1
          statsTitle2.text = title2
          statsNumber1.text = number1
          statsNumber2.text = number2
     }
     
}


