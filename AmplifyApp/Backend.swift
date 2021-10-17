//
//  Backend.swift
//  AmplifyApp
//
//  Created by Bailey on 10/10/21.
//

import UIKit
import Amplify
import AWSCognitoAuthPlugin

class Backend {
    static let shared = Backend()
    static func initialize() -> Backend {
        return .shared
    }
    
    private init() {
      do {
        //Amplify.Logging.logLevel = .verbose
        try Amplify.add(plugin: AWSCognitoAuthPlugin())
        try Amplify.configure()
        print("Initialized Amplify");
      } catch {
        print("Could not initialize Amplify: \(error)")
        return
      }
        
        // listen to auth events.
        // see https://github.com/aws-amplify/amplify-ios/blob/master/Amplify/Categories/Auth/Models/AuthEventName.swift
        _ = Amplify.Hub.listen(to: .auth) { (payload) in

            switch payload.eventName {

            case HubPayload.EventName.Auth.signedIn:
                print("==HUB== User signed In, update UI")
                self.updateUserData(withSignInStatus: true)

            case HubPayload.EventName.Auth.signedOut:
                print("==HUB== User signed Out, update UI")
                self.updateUserData(withSignInStatus: false)

            case HubPayload.EventName.Auth.sessionExpired:
                print("==HUB== Session expired, show sign in UI")
                self.updateUserData(withSignInStatus: false)

            default:
                //print("==HUB== \(payload)")
                break
            }
        }
         
        // let's check if user is signedIn or not
         _ = Amplify.Auth.fetchAuthSession { (result) in
             do {
                 let session = try result.get()
                        
                 // let's update UserData and the UI
                 self.updateUserData(withSignInStatus: session.isSignedIn)
             } catch {
                  print("Fetch auth session failed with error - \(error)")
                  return
            }
        }
    }
    
    // MARK: - User Authentication

    public func signUp(email: String, password: String, completion: @escaping () -> Void) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        
        Amplify.Auth.signUp(username: email, password: password, options: options) { result in
            debugPrint(result)
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
                
                completion()
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }

    public func signOut() {
        Amplify.Auth.signOut() { (result) in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }

    // change our internal state, this triggers an UI update on the main thread
    func updateUserData(withSignInStatus status: Bool) {
        DispatchQueue.main.async() {
            let userData: UserData = .shared
            userData.isSignedIn = status
        }
    }
}
