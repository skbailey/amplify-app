//
//  LogInViewController.swift
//  AmplifyApp
//
//  Created by Bailey on 10/17/21.
//

import UIKit

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        print("user signs up")
        
        guard let email = emailTextField.text else {
            print("missing email")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("missing email")
            return
        }
        
        Backend.shared.login(email: email, password: password) {
            print("Segue after login")
        }
    }
}
