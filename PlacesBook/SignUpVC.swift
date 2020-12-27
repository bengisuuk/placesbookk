//
//  ViewController.swift
//  PlacesBook
//
//  Created by Bengisu Karakılınç on 26.12.2020.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != ""{
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "Error!!")
                }else{
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
            
            
            
            
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username or password can not be empty")

        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != ""{
            
            let user = PFUser()
            user.username = usernameText.text!
            user.password  = passwordText.text!
            
            user .signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ??  "Error!")
                }else{
                    // Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)

                }
            }
            
        }  else {
            makeAlert(titleInput: "Error", messageInput: "Username or password can not be empty")
        }
        
    }
    
    func makeAlert(titleInput:String, messageInput : String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil )
    }
    
}

