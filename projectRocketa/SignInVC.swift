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


class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
            
        })
    }
}
