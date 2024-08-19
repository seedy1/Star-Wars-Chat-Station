//
//  LoginViewController.swift
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton){
        
        if let email = emailTextfield.text, let pass = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    self?.performSegue(withIdentifier: "LoginToChat", sender: self)
                }
            }
        }
    }
    
}
