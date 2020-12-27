//
//  ProfileViewController.swift
//  Sports App
//
//  Created by Dmytro Yurchenko on 27.12.20.
//

import UIKit

class ProfileViewController: UIViewController {
     
     @IBOutlet weak var done: UIBarButtonItem!
     @IBOutlet weak var name: UILabel!
     @IBOutlet weak var profileImage: UIImageView!
     @IBOutlet weak var view1: UIView!
     @IBOutlet weak var view2: UIView!
     
     var username: String?
     
     @IBAction func returnBack(_ sender: UIBarButtonItem) {
          self.dismiss(animated: true, completion: nil)
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          name.text = username
          profileImage.layer.cornerRadius = profileImage.frame.height / 2
          view1.layer.cornerRadius = 15
          view2.layer.cornerRadius = 15
          view1.layer.masksToBounds = true
          view2.layer.masksToBounds = true
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          let destinationVC = segue.destination as! StatsVC
          if segue.identifier == "VideosAndHearts" {
               destinationVC.picture1 = UIImage(imageLiteralResourceName: "video-icon")
               destinationVC.picture2 = UIImage(imageLiteralResourceName: "heart-icon")
               destinationVC.title1 = "Videos"
               destinationVC.title2 = "Hearts"
               destinationVC.number1 = "354"
               destinationVC.number2 = "3800"
          }
          if segue.identifier == "GamesAndWins" {
               destinationVC.picture1 = UIImage(imageLiteralResourceName: "game-icon")
               destinationVC.picture2 = UIImage(imageLiteralResourceName: "win-icon")
               destinationVC.title1 = "Games"
               destinationVC.title2 = "Wins"
               destinationVC.number1 = "540"
               destinationVC.number2 = "333"
          }
     }
     
}
