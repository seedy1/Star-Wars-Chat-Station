//
//  RegisterViewController.swift
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton){
        
        if let email = emailTextfield.text, let pass = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: pass){
                auth, error in if let e = error{
                    //TODO: add popup to display err
                    print(e)
                }else{
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
        
    }
    
}
