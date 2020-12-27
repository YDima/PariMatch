//
//  ViewController.swift
//  Sports App
//
//  Created by Dmytro Yurchenko on 24.12.20.
//

import UIKit

class ViewController: UIViewController {

     @IBOutlet weak var username: UITextField!
     @IBOutlet weak var info: UIButton!
     
     override func viewDidLoad() {
          super.viewDidLoad()
          username.delegate = self
     }
     
     override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(animated)
          
          info.layer.cornerRadius = 13
     }

}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
     
     @IBAction func showInfo(_ sender: UIButton) {
          username.endEditing(true)
     }

     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          username.endEditing(true)
          return true
     }
    
     func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
          if textField.text != "" {
               return true
          } else {
               textField.placeholder = "Write the username!"
               return false
          }
     }
    
     func textFieldDidEndEditing(_ textField: UITextField) {
          self.performSegue(withIdentifier: "show", sender: self)
          username.text = ""
          textField.placeholder = "Enter Username"
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if segue.identifier == "show" {
               let destinationVC = segue.destination as! ProfileViewController
               destinationVC.username = username.text
          }
     }
}

