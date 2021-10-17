//
//  SignUpVC.swift
//  AmplifyApp
//
//  Created by Bailey on 10/17/21.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var passwordConfirmationTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        print("user signs in")
        
        guard let email = emailTextView.text else {
            print("missing email")
            return
        }
        
        guard let password = passwordTextView.text else {
            print("missing email")
            return
        }
        
        Backend.shared.signUp(email: email, password: password) {
            DispatchQueue.main.async() {
                self.performSegue(withIdentifier: "logIn", sender: self)
            }
        }
    }
}
