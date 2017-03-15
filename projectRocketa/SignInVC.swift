//
//  ViewController.swift
//  projectRocketa
//
//  Created by Michael Ballard on 3/12/17.
//  Copyright © 2017 Michael Ballard. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController {
  
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Before the user sees sign in, app will check for user credentials if exist loads automatically
        
        
        
        
     
        
    }
    
    @IBAction func fbButtonEngaged(_ sender: Any) {
        //Authenticate With Facebook
        
        let loginManager = FBSDKLoginManager()
        
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in if error  != nil {
            print("MICHAEL, Unable to authenticate with Facebook - \(error)")
        } else if result?.isCancelled == true {
                print("Michael, The user canceled Facebook Authentication")
        } else {
                print("Michael, User successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: {(user, error) in
            if error  != nil {
                print("Michael: Unable to Authenticate with Firebase - \(error)")
            } else {
                print("Michael: Successfully Authenticated with Firebase")
            
               // !!!!!!*******  if let user = user {
                
                    //Figure out how to implements so that a user does not have to relogin every time....
                    //KeychainWrapper.setString(user.uid, forKey: "uid")
                
                
                    // Bug log: KeychainWrapper method setString could not be found go back debug an complete auto save login feature   
              //  } *********!!!!!!!
            }
         	
            
        })
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        
        
        if let email = emailField.text, let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("MICHAEL, Email user has been successfully authenticated with firebase")
                } else {
                    
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("Michael, we were unable to authenticate with Firebase using Email")
                        } else {
                            print("Michael, we successfully authenticated with FireBase using email ")
                        }
                    })
                    
                }
            })
            
             self.performSegue(withIdentifier: "loadMainFeed", sender: nil)
        }
            
        
        
        
    }
    
}
