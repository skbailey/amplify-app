//
//  UserData.swift
//  AmplifyApp
//
//  Created by Bailey on 10/10/21.
//

import Foundation

// singleton object to store user data
class UserData {
    private init() {}
    static let shared = UserData()
 
    var isSignedIn : Bool = false {
        didSet {
            print("isSigned set to \(isSignedIn)")
        }
    }
}
