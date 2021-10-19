//
//  HomeViewController.swift
//  AmplifyApp
//
//  Created by Bailey on 10/17/21.
//

import UIKit

class UserConfirmationViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var confirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Backend.shared.fetchSession()
    }
    
    @IBAction func confirmUser(_ sender: UIButton) {
        if let confirmationCode = confirmationTextField.text, confirmationCode != "" {
            print("confirmation code: \(confirmationCode)")
            
            Backend.shared.confirmSignUp(with: confirmationCode) {
                print("confirmed user, proceed to login")
                
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: false)
                }  
            }
        }
    }
}
