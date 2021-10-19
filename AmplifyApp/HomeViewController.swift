//
//  HomeViewController.swift
//  AmplifyApp
//
//  Created by Bailey on 10/18/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Backend.shared.fetchSession()
    }
}
